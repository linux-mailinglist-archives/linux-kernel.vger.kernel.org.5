Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC46580440D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbjLEB2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEB2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:28:11 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2792109;
        Mon,  4 Dec 2023 17:28:16 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4JAVxE023895;
        Mon, 4 Dec 2023 17:28:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=31mR3ihS3QMvdRPsm/YNTbN/xOpJkxcDoSHhzRP2l3M=;
 b=hhXdw9SN2+cqXNCry2m0V8BjcmQ6m22lg0crI+PVMJj4B+iHMF4UWWNubh6noQzSzI2P
 9GPL3VO6H5sDO2lXQGFo5/XMnuYlSRH9or2TABilQLLtIcGnzHsHSlI0t17fQ8h7SSSS
 RenzsvRRn8WcDc7urgNqDuzQJ+MKoNVsoWgosNRXBrA+CJWoc0fPAhrbuqP5re7pq7FL
 7Sd3sYOO3ks4ExjTF4bo3l02KTGJrvMp7g596Cl61zQgnCpCwFjbmyvjLdVG7JDO6tso
 s9ctwP87Tm19sMiOjlw3Q+ihp7n7qe+DoumfKm/zxHVrvjzIOVntpMzWJXldFI7WlkXO Mw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3urnp47cvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:28:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701739681; bh=31mR3ihS3QMvdRPsm/YNTbN/xOpJkxcDoSHhzRP2l3M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NEVFi8I+nvpME+rjPdj28gYGrQb2r6eG+Z634linh5slaajCxg/QsMGJ0q9/x3aQ/
         U2qlKVsaQ4UFQ39ZxjS9s+XUguQFRz7HJed7m428jPYnPPaYpLm2FZqxsQWiftNxnu
         fN2az483+/RJGHoUlWU9g3PbYhaX03u+gCYETn3KDgFZ1mSWAL0C7UFSEzxVtwExYi
         Ud+xi0Be8Blvc0zWxDGr+531VwX2OPtY4QuBXkdwZjEnrAGlelXlOqvK3DhqK9g+lg
         KaLR981VLseKtE0nWm/mjl6sQkG5EbYg5X/Yy+K5OtlupY2Db7CgCwQS6pC3Ap2GdP
         nrLusdQFUuL2w==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2209240407;
        Tue,  5 Dec 2023 01:28:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 91907A0082;
        Tue,  5 Dec 2023 01:28:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=oijP3bOJ;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AE4F24041D;
        Tue,  5 Dec 2023 01:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmwiCHY1a5T1V27ZhCZ7u/SEamoeBKQlD+XMii5v3Noy3m+clKMjriQwKniUsCAsecc2jdSoISTkffHZUVjK2Eeo5CjFfJgT3S/89XsTUWEmCi4tbBFLxxye8S2qeb9SHWYvzgYMjzg3/KmZFS0hDnXnrRLXJeHLOVMuEPQvQ7A/cidfBo27Fwm5WglNA0cu19gOQNh4mVCabqfW9e04LEes8ukPKEZ4SXf6p7rNXUeZNvJO7jypTsFu4PVHvAvZjLruawBo3I6IfWvZHzK7vZbjUtqjoO4eo5FlcPRrtSfpO9/RoPVTi1JOef/TzQ5Ss8gsxqZnoxZz1o9scq9xOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31mR3ihS3QMvdRPsm/YNTbN/xOpJkxcDoSHhzRP2l3M=;
 b=iXn0FUULoJqHG/hs5z2KBSe/ozYmYA8RazLqwE2J790Kgh+QBEcTsOebdyopFw0nemgua06nUBZNj+kRvG68Qa7VhSg/M+tuW2dg4zEkMmctAoQxV7FyUTMKcT7mYPf9QPns+wqkd4U5+IZ/xV6aYL1KhDhCkXvojbMfBGkfFLJmJAsO3inkwdHl4p79WI36QyoM7rQjBIIQOv38/S8G4TCAQGE9dtxUYlCCbNe0u6aI5osBdbeMnXv2nxOaQq2fVkTMFGMX+gDne9NiXAdx0lQi8zURHrp8l/HPQiDVF+JhVzUmRUCO8WIdjEyp+SohrvIq5HYBmX9OnNomATr3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31mR3ihS3QMvdRPsm/YNTbN/xOpJkxcDoSHhzRP2l3M=;
 b=oijP3bOJ3WHppoZuPLlANqxpsxD6yGNl+IMYv0VqgXfipECtY6Bo6Nqeiga2hv8LH4WJTFFn3ya18jZvLxOjTjyeNcaeic8W7DINtC8MXhKYiajotO2TZSTD5N5bs/U/C+Y0jhxyFNEVjAinGEk+eHIRWmFADD0lGQ+sxISSaJY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 01:27:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 01:27:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?S8O2cnkgTWFpbmNlbnQ=?= <kory.maincent@bootlin.com>,
        Jisheng Zhang <jszhang@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu jicong <jiconglu58@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was configured
 as host-only
Thread-Topic: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Thread-Index: AQHaGKveCMbrfcJ+4k2eyt7FIy9Uo7B9K1KAgACReACAAAQjgIAGzbeAgA+sTwCAAQATgIAEyCGA
Date:   Tue, 5 Dec 2023 01:27:56 +0000
Message-ID: <20231205012745.nt5gxlim6gljpi36@synopsys.com>
References: <20231116174206.1a823aa3@kmaincent-XPS-13-7390>
 <20231116175959.71f5d060@kmaincent-XPS-13-7390>
 <20231117014038.kbcfnpiefferqomk@synopsys.com>
 <20231117015527.jqoh6i3n4ywg7qui@synopsys.com>
 <20231121104917.0fd67952@kmaincent-XPS-13-7390>
 <20231201100954.597bb6de@kmaincent-XPS-13-7390>
 <20231202002625.ujvqghwm42aabc2f@synopsys.com>
In-Reply-To: <20231202002625.ujvqghwm42aabc2f@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5389:EE_
x-ms-office365-filtering-correlation-id: 6946f00b-4ab6-4d8b-4c97-08dbf53168aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nyFtqe4t5D/fgb3mqyWM7w+hGCr8gIBjG1sK+26NRGOBeM4o27VCgDP2BnBZQ/da2P3SBzY8/qepJeTI5k/82peQ4I6y46GWz3IXndwpMIcmC8/WrXTFtNBinwhPuoUVzIPpuqxcHvDzk/jS7iDTEufl+7yhRHp2bWZ41sF7J02BDzqTD9xkcV/hv5E0M/7kEV9eLZcJh7Cpzt/zZ2uoFzsYKcLktiXcguQtZsyvsw0o2aDw4iQgk7BRA/aCtBh865BtrgpbI2CURAPDoYatHgwdGPc9auudpV6o6cHRCRjG3iQW4XT1gnBLatEashhcJgxY7FzDGaTV1WcQwsrWpPU5jLo7Y9h5VzMC4UywhNWy55z5HmZocVRM+tL3P8n+O6y+t1CwRRvfYie3YzqV8t2hv0pjLZpZN435YLt1C+7qzkBgzZBvB8DNLpIF6XBHktEQHW45GYXd9HVlo3hLxJJON2xOlqn4OxtbZo/KxARDRMu9eH6XjCT+1ZGwEhuS27LPAoG76YKYTWNj+5zyjtteEBnfGVAuxP9/KsVKuP6tXHEaX0jGwZv1JX84STAyGkeek0jo6nMxKOKCWJiRwp9kjE9AIkaXBxgYZrJeBIWi8HSZeqawAlmLs85A0oep
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(66476007)(66556008)(66946007)(66446008)(76116006)(110136005)(54906003)(64756008)(6486002)(91956017)(38100700002)(2906002)(5660300002)(558084003)(86362001)(36756003)(41300700001)(38070700009)(122000001)(4326008)(8936002)(8676002)(6512007)(6506007)(26005)(1076003)(2616005)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUFpdzBWZXFMcHdoejdhSEJsbTZTUmRLRlR0UU9NTDFydDF6ZytyT09FMWY4?=
 =?utf-8?B?WDFQZ3hWdU5aZmZmSzRUaUVLQnR0aU4rRXlSdjFaV0RiQnRLdWY5ZkJPWllv?=
 =?utf-8?B?Q0NKYndTRElkb1prOWxPaUt2MmYvYXhMVUQ0d3U4ZTY4WFRkaTF0RG9DRHh0?=
 =?utf-8?B?dDFwamVhbk04bTFOWk13cjEwOXZKZmF2RE1wVnRSQ0ZodVJsNWcxKzluZmNk?=
 =?utf-8?B?eENVQWVoSWdwZm1tV09jOWk3bzJnZlRzWFFrWTlBMzlBZkxUM3k5RnJ1Y2tI?=
 =?utf-8?B?b25SUE5XUnd0T3JjQ2pMVTNkTVRxcFpOR1hUQ01YZ09GNjZreUExQVVEaU96?=
 =?utf-8?B?V1p1S1I5NWM5RVNleXlTaFdqNCtCc2NtNHg4TGRxR3VGdzQxcEhZTzVZaW9E?=
 =?utf-8?B?WHNJSXYxL1FsZDIvaWhxMlE0M2VQYVhkTkQ4MEh4UmVVcDVxdW1Zc0hTTmw4?=
 =?utf-8?B?b2k5TTR3aFdmT3ZwblRqYXpjMDkrWHpFelk4bEhUWEhyb3NyU3djUkpyN1Ay?=
 =?utf-8?B?azVqc3VJbm1YTXZ6R0JscnZ4azRmZHFvdzFvS255TU9QaWsxd1phalhib1Jj?=
 =?utf-8?B?Z2tVYmNsY2NTa0pLOVZ3d0ovTU1BNDJPeW5tMDc0dzFydzJiZ2xmU2N1blFN?=
 =?utf-8?B?UitxTjBHWVI0WlMvZEphRWw2MWdNNVMyQlphaHc0dVV5cVNydzZlMy9xcTg2?=
 =?utf-8?B?a20yR0FZK0hLbHBueW12cXR3M3JXUFNadGVaZkNXeUJSc004V1ZmMkJhOHRk?=
 =?utf-8?B?eEFwSDRHU1hDYVovR2dZZEEza28wOHBBNDZXRTlXeXJPSkROWmhlNE1OcXZX?=
 =?utf-8?B?bElTMlBCRmI0czFWeHlqK29OemdiVlFtQ0EraGlGZ3RBV1ZOZXZ4NmdCaERK?=
 =?utf-8?B?RTBDeENEdERDWDJsN0FQSVZkaGZlTjZ6NDJqZGZPa0p1enVWRnVDWDFjRVZU?=
 =?utf-8?B?MkwvaGZUUkFHNTdDbitKbXJLbG5GT1J3WVcrT2tpbXJlRjQ4cmNmV2hKRVNt?=
 =?utf-8?B?b1MyaStQcHdCRlYzRzdLT1ZUSTg4eVMzcSt5TWJXWUZiM2RDaG44SkpsbGI5?=
 =?utf-8?B?dXVoSFFtbjlBR1VkMFRCV2F1SXlITnA0TVVzMW1mWkhDQkZ6azhvbi9GS3Ay?=
 =?utf-8?B?WnFYa0ovN1FCOTIwV0lzdzYxeGpTcE15THUva1VNeTFJRkxzUmx3U0ZpWitw?=
 =?utf-8?B?ZnFUdnJVY0kwSDFIVml0OHdKVFQwYU9IMHRXUU9vWjZpV1ZOTjZkQkxoc2Jr?=
 =?utf-8?B?RExCdTd5aGZGUWc3OUVYVTdlNTNhQkJHU3ZUMjdYQzhDMmJoTUZkTnpBMEwr?=
 =?utf-8?B?U0JmY1VNM01tWExOM0VjZVNveU8xdm8wS2F4TGlHMHloUmRGdU9hbEFreE42?=
 =?utf-8?B?MzBFQ0VLOE90TU5qcWxmR3Q2Q3RMMDAra0FEMTlqZ3o5cXdDcGpqZGVQNGlj?=
 =?utf-8?B?N0NzaER5TWI5OVliRHBMRXlzTmc1c0M5QmhlZjlRelUxcy9LZlZtK2NkVUZk?=
 =?utf-8?B?M3hUODQ1VXAyRmlIbUptbWROWWlaVUI0bTlGTGVOaTN5QVc5K3JwSVhBaTVH?=
 =?utf-8?B?UFF6clNOZVQvdVlxSEJFdnRJZXFjSUp1aWFhUU5oc3RyeFRpZ2xzenJwZXMy?=
 =?utf-8?B?ZklMTDh2bWJmdE84OC9yQlFaTDZqTkV6SjlmMnNVaFpaRnNSc1laVnJvS1dh?=
 =?utf-8?B?cVJjV0pjNWRmcnRwZEtFWEZ2NzdJejVBUFFwaGdOU1AwMEdndDgxKy8wdXBn?=
 =?utf-8?B?UlBxNEZ4aWtySVhpNFZURXNtU0ZTV1g3OWFPb1pzOGNGelM4aTY4VUp4Qlgz?=
 =?utf-8?B?SlJWSjVwMkRQT085TlNIZEFZdVpBVHAzR1l2dGE3R3o3YjhpUFZPYnIyOWJD?=
 =?utf-8?B?RkZ3aWd2ZFdKZG1DazNtYVMrcklTdWdrejlET0VSUlN5VjdmeTNYTXpSQnJ3?=
 =?utf-8?B?ZmRab01YVHdlUGRwa0psbytkVWplYU95RForUWE1WUxLMk1yUURpVlplUzYv?=
 =?utf-8?B?d2ZtK2ZDVmpDT1BqM05aWkZJUERiQ2RIaUxBbUFhLzVGcXdsWFJralhoMktm?=
 =?utf-8?B?QkRGN2wxVWxxSjJ6c2tFMEU3MVo4VHY4eDNxUlJDd09hR25LVnJQSXprSndo?=
 =?utf-8?Q?6ti9GCzv8lMtjOJix0y7Ibh4t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43FD9BD0047F0441BEA1508D26D8DE98@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bXNNSGVhSWhlZFNzay9EY0xZUHhTWnlLS0RWVzhraCt0RUJSbGw4TXdSbm5o?=
 =?utf-8?B?YWUyQk16V0JYUXdEbUVFTEo0ZmxNNGZBa042a1hONTg3bFhMbTl1bUZLZHBG?=
 =?utf-8?B?b0wwUDhuUm83Qng3QmdsejhXb2gwdkhEeklVUHZzMTNScTAyV2pzNlVOT2c4?=
 =?utf-8?B?ak51YW51WFY1aXhwN2lzMDIvaXFEUVlCNHBTQmViTlJjQk52US9Xb3Bkc05L?=
 =?utf-8?B?TzE4dkFXTk9ieDRXb0hUbzRCYnk4MzV5eVhOY3QzaWU2R3FQa0x2ZGRqaWxS?=
 =?utf-8?B?RG5aTFg3UlZzM3pUVkIzbzNRaUkxQzFBeklNeVdOZXRaQ2lDMzVDUEg5RGpJ?=
 =?utf-8?B?cU8weW5xdmlLM2paTHI2a1JlaG4zQW11NUFQWE1Nemk5RzFCVEtLa3B4YWUw?=
 =?utf-8?B?TU9rYnFmWUNmenJ1LzNzZFZKazFycDI3QUd1bTJyaEVrTE5ONlVUd0JGKzNi?=
 =?utf-8?B?a2ZJS2N2VnRDNTMyV2JvbVZSWUhMNFFjTnlWaGVtaTI2aDU3MUtUbXlUUEg2?=
 =?utf-8?B?OElwYlVZNlhrQVkyM3RZelFuSG5jTUc0S3o2ZFhJeGxKTEU3eHFjR1A4NWZS?=
 =?utf-8?B?NHViUmk5SXVjVlZXUTVtbWVYUDhTNnFDYTV1b3JnTFoxTFovWmJZOHFhdWZX?=
 =?utf-8?B?ckdPcCtmRkJ3bGpWNG9mdndRNlU2S3VnRkxRemcydVZ3MkNvZ05iNWxkMU9p?=
 =?utf-8?B?UkpMcnVLSlJ1ekgxQk9SaHhJZXZuUU9WQWtrNnQrTVpLZUtCMGVTa1JjVjNo?=
 =?utf-8?B?K05uWVNjekswTEhiNW81SlczcUV1TDdpQlZkditQNDFBYmFFeHNqK2ZocDNq?=
 =?utf-8?B?NUdHSjg3MlJ6dDI4V1pHTlVVSTRBaDRIUkg2RTE2Z0luRGVWUWxvcC9YaVpW?=
 =?utf-8?B?N3hGUEhNVnVSbjhrMWlDSFRNbW5uamgxM00vZGZacE9CWDhidm1LV0NNV2hs?=
 =?utf-8?B?TzRlakRFZUd5SFBtbnJ2MndvY0szZnJYY0phb2dKTW1ZUDdvVFdyclJwVnUv?=
 =?utf-8?B?eFFrUlhpMFRFamh0TjR2NVV4WE1wTXljOVcvOFVFSFY4SWdBUGdkMnRkR0ZB?=
 =?utf-8?B?MWdNd2xhblJLWmJENmU5ckRlOHUzUTdsRWdBL0NXWXNEVWtuWm5xTmVGMkMx?=
 =?utf-8?B?ZzN4eGFndTQ0YzFnTENOTG5hSVVGT2lpU2hLK05DaE1qK2dvSkJLV3AzU3ZZ?=
 =?utf-8?B?WjBwd0plUnNBS3BJZVAxWFI5M3N3ZW5Yd3dha3UxZ3ErcUpVRTVudDF5ZElh?=
 =?utf-8?Q?K1afYL8EF/PnBtb?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6946f00b-4ab6-4d8b-4c97-08dbf53168aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 01:27:56.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuJDa8kcqWpoLud9DYqz6HPdFi4iyCIamSWuZtJC5h2KFTv+P0JYHADySHb7HCK8F/YvX1DYtU89J5g+K0i+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
X-Proofpoint-GUID: Cz9DZNSUiH92pcu_Mr0dN16rXi9GeW7n
X-Proofpoint-ORIG-GUID: Cz9DZNSUiH92pcu_Mr0dN16rXi9GeW7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_24,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=512 mlxscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBTYXQsIERlYyAwMiwgMjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiANCj4gSGkgTGlz
aGVuZywNCg0KVHlwbywgSSBtZWFuIEppc2hlbmcuDQoNCj4gDQo+IERpZCB5b3Ugc2VlIGFueSBy
ZXBvcnRlZCBpc3N1ZSBiZWZvcmUgeW91ciBjaGFuZ2Ugd2VyZSBhcHBsaWVkPyBJZiBub3QsDQo+
IHBlcmhhcHMgd2Ugc2hvdWxkIHJldmVydCB0aGUgY2hhbmdlcyByZWxhdGVkIHRvIHNvZnQtcmVz
ZXQgZm9yIHRoaXMuDQo+IA0KDQpCUiwNClRoaW5o
