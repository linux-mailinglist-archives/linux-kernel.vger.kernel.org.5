Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3A7861B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbjHWUoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjHWUnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:43:40 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7110C8;
        Wed, 23 Aug 2023 13:43:38 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NGk44U022973;
        Wed, 23 Aug 2023 13:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=p2kKjdyek0BIiv8gc1qzl3VTJQnR4ZSR8k2A1uFowqA=;
 b=RGTZoIYppzpln1NYq2L3MA5iUDHtQrumIUD7sWZwCdI5G+S+jRz1etWgTEGoYx4ZjbGQ
 KYnPX9WNp/L2EFAAvcxW/n5t5YfIVxidkUGpXa4muxG0FA392Zv7P2cfedvJWHpY9uTn
 9qx4zOXugaqMiB6s2Pds5gXoUwpvbfzPvScAbKZYeRWroZ+gcPvZL8fr7vWQATRPdE/u
 wncHE7tONJ+cAoffgh4Ig5N1yEoWhj9EmwkMKeKgpGPl8OILFjRoYoMkyOLAFVTG26uD
 g7lpWWVR/esY5Ix/fLD0nrCaymlh5+gn6C3Z8cPrKqo6wcLWxUZXOJbnEztR4Ms0SShZ rA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3sn20uervk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 13:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692823404; bh=Rs6X79pdS5RdmPEklE+G2aeK9PO6T1utz8HrkiIL2pQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=E+CoEoux3btu+mpvz+IBLjfhpXxw5lH9Ab+xdy/VmcdFNYZXE76vPK8hZcizwyVxV
         uMXDsJpX35xzkEnIFBxQdm7FlalkLycn3OIKu5H7riKkukBpFT48JVj/i2BrTSNb6G
         IJRjuLesnQ8GhKR+FrSRWrqANDBaNrTiBsC5Q3mHnt5wyuwTY+3zSi0gxUtWHi+HoQ
         bnaOxOQ2MPMPqjJcmA07LBQ5rbG3UhyZA5HtQakXEYVf3BE3s7WjQvZCvmT+WN/In1
         mhD9aBYDi7WQPaazmBLuGdsh5mKt+17ojDcxbId775JzrKbbumeexEh9w+Wck+bosm
         ZoZUTuBoncaog==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4A9D040145;
        Wed, 23 Aug 2023 20:43:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CAA88A005F;
        Wed, 23 Aug 2023 20:43:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PUPIHjzJ;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0980A4013F;
        Wed, 23 Aug 2023 20:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhFYI19JqPBNCvdcvW1n70qmHgJTQ/OpdyYe1kRvBWIs+5WlAzk1EJPGmhuPcvbAIQrus6uYlDHJOg2qmpL4bB6QuLtt/AXRZn83GeOD0aDyx9MC9waPlomBsoSZiW1wQJak+z6OhTI+Haton/p/ny1y8szD3eRW6LLSUkyhwMn0kGEfxmyPgIWUf8M+ZkJjdbxn2Embs7AW9VHOA7s0yIUGCPFITBKObFow5BxDVXjJSRVjtIydCH3RM1lbTrETOaC6OLL0EaH1bJHlX+3t/SzspPKYsNZ2jVohwUoabE+Lig9uQ1S+qTAdQzAMfA8OE4Be2MwOuAxUdrig95VOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2kKjdyek0BIiv8gc1qzl3VTJQnR4ZSR8k2A1uFowqA=;
 b=Ruo/tT7b9DG1vry94G9OwpYH/PKrH5A39iW5+r0a75SDuY6pjfTp0MLNC4tiYqaDnRFwK7sk057LPKOP7vGIH1VFejMrWURuLDr34859XwRDXgaIo50J6GfYmEXd4nwkGVSXEdUZ7FCntnJ0b5kroDxEn7NJcV3YvfzYN75V7YIbHDDJPYFjgd03uFLkqrhnkoYtvhxoLh4FFagM0VeHO2tbkVNSEugsGqHFvihkt5S8Kj3C47jRWJO8ACc4PzHYJvlACu6g/Fmw8CWmw/HnpaVnJeHggJNuXp6xclVkvjrcPMKQ1F2ujqrhOm+6UY2DK01XIpiBJZgGip2EPvoG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2kKjdyek0BIiv8gc1qzl3VTJQnR4ZSR8k2A1uFowqA=;
 b=PUPIHjzJJ3rbhbt0lzUiYUb9P4TDluBh1Ky0dUjzC3LTel5wBoqOCuk9j4BDdSKHEDG80H7yAPDGZPzSb2p4Z92TrD2wakp6LQFeRUPybL7Hauy6hVU0gsK5ta7WKlnsB5hIDSuGSc2+Z2wMfR0F9xMB90gg9fy9eSRatzSylxc=
Received: from DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) by
 DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Wed, 23 Aug 2023 20:43:17 +0000
Received: from DS7PR12MB9041.namprd12.prod.outlook.com
 ([fe80::d13e:94be:b491:40c3]) by DS7PR12MB9041.namprd12.prod.outlook.com
 ([fe80::d13e:94be:b491:40c3%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 20:43:17 +0000
X-SNPS-Relay: synopsys.com
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH] arc: Explicitly include correct DT includes
Thread-Topic: [PATCH] arc: Explicitly include correct DT includes
Thread-Index: AQHZtnpD54rdQx1ml0KYeICwmilFg6/4WaqAgAA+Gxc=
Date:   Wed, 23 Aug 2023 20:43:16 +0000
Message-ID: <DS7PR12MB90416779F78229EDD1750A33A11CA@DS7PR12MB9041.namprd12.prod.outlook.com>
References: <20230714173949.4038981-1-robh@kernel.org>
 <20230823170025.GA2470216-robh@kernel.org>
In-Reply-To: <20230823170025.GA2470216-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9041:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: bee06e60-9469-4a92-e973-08dba4199430
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCotwNnIysyyjA03v4GVQgsfywH52RDoy1+v31/FjzOR9QrFnNKA3YyAiLQZwkufYhRA8/zJIwvinK65JsOkADsHCLil5lg1Eg31MqOKT/CKlHleY7QjAhX/1qa0Q8/PxrpC0UREoPSLvIKzWT/KEDoo+Tqj+obzc1Wlc9/yO/bjmAYLp6z0hf0+tFcWyNERp3G0LCf1kuR7vC2hxdufQTojZSgQNYKR/clVFEMr66T5xPrdg/GCglWUOeHraFktt34jYkZewZ/r1Sk7NLA3yWusYwemWOMgkQJMZdFs5oBd3xPNpE4jNNqSIX9rtn/vPjQSTDCT0x2OTIksNRK8M8TXtDPBgp0V7AL1kGwQefiEy0EQWrRMYL5aB762NcrCLB/Z5+KeehWljyx14uAKF5aLGZuOP+NtAiuHaVsLyxest6RixPj0w+00v1FadeZCb5hwsclKl92C0XPrgJWRsw9xr1CvwyFZA8d57iLhMVWQYvasR+M1UtR/czthECPud+WaYXo0+f2wd1DFwTCaiGnVcWe0T4CfnuE4vz7X3iCFIohgQ0tlV/7rAN7+DyVT69k/mebw8EeOZUex4VmMJSwFWJ9MuU3FRLCRkLrZ7ZjUhDexBMYesIJXS6okERk0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9041.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(54906003)(76116006)(66476007)(6916009)(66446008)(66946007)(9686003)(64756008)(316002)(66556008)(91956017)(8676002)(8936002)(4326008)(41300700001)(478600001)(55016003)(122000001)(71200400001)(38100700002)(6506007)(38070700005)(83380400001)(2906002)(7696005)(86362001)(5660300002)(52536014)(26005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ULhwstZMl5hvXr0guq5bIORwboaWve+cAVbACSeMtsB0H5C94d9ihwATvA?=
 =?iso-8859-1?Q?lehseZsEpipmw6leYaKEY72MhBfbxMd3CWjQg8talu0QLjalObTB5w8X2j?=
 =?iso-8859-1?Q?9XRFvAKpWNlFRqFRdVgX+RDVTEvFgM5I3EZ9Sgeg5p7yKCiaNWtw0PbLDw?=
 =?iso-8859-1?Q?iw8aeeqaiWHambWNvJYYeAbYuY2Xzz1leAsA7q+WO9550jZ3kV3gSfsSGm?=
 =?iso-8859-1?Q?jGWEQvNJ+dpEGekVsbWQtDnXAYzfAkFecQ9/zFfDWRUjdpWdohH4ppkXZ2?=
 =?iso-8859-1?Q?rJY/0TR8VLq+IAnmXiShVNIEZvO6uk5vwX8tMEvu6KoWfsPwElhR1ea4gE?=
 =?iso-8859-1?Q?xzKxj+grE0up1rJzcBvwgLDkM+gTKU9o1e2AfTtqkvd/xIDvKJwGma+4XK?=
 =?iso-8859-1?Q?6YgCIClLbQpqKZnPJAq533c1ChXHzGhbnRp2oRYqkAKxFmTLbtAnrLwwoN?=
 =?iso-8859-1?Q?W5//hJo13Fyi71MU7bawihBeMDwX7XXHvt0McLPni5/0qvxvZOgJR8sQZQ?=
 =?iso-8859-1?Q?FnZuNIfSn+3eVkmP1Rgjdll/j6rQRGiYWHY90NXUEsWTMpf5KqAPDhx++3?=
 =?iso-8859-1?Q?JyyOEoSQgkac9IUVW2ULvegBSe4uqb2oD8meAFnzAjHtG5csJqhR5ofag1?=
 =?iso-8859-1?Q?BE5iQgNBgkiadbSJ9Mao7R774O7nwuBo6t8WoJe85xgEf3Yfz+W6gzGqtT?=
 =?iso-8859-1?Q?YZo1xSCgSm2MCMPrVlTyBDp32i2kAezub1SvOxibEmEWev8TcQYWvSRh/j?=
 =?iso-8859-1?Q?W2fdbx1s4jKiDa4zY24pWC987S02ssweZ2VhKv91iplLo+TihPCT9YUbcW?=
 =?iso-8859-1?Q?fUO7d/9zgvLW4UDJtMzBLG7oXyfd52u18mESrdSk7mk6aqbtisa1E6/mDr?=
 =?iso-8859-1?Q?TAfJv5SwO8VpY/MGaXfZDsaCODtwlrHN52ZP7WCWOZnu8u4ZhEO3ZWp+4C?=
 =?iso-8859-1?Q?qqDBtuuwvHfdhPyAuOZrigGPmGeL3LtkMv6WC3KqAPfnD+77ZtTCECxDxn?=
 =?iso-8859-1?Q?Nl8cEe9Q9RLyQYXSg7F4C8uOUiHZh+1PnLIE+RpmTQZn3w2CRiHaAL2Qbc?=
 =?iso-8859-1?Q?FjLH9zq/3TlCYyeCp6x3bVxv+YihIqfjAb2VWcI2pO2LUF6ZrkEEb7FgIA?=
 =?iso-8859-1?Q?5pAz7tm+AbmAWWRJ6xh8CPwfMyYnaFsgNSmgGybSl8eU8ZoBxVISO+Olvo?=
 =?iso-8859-1?Q?fYz1kyF3IJ/77wFftkvyxf2I3VF3OJTX2Rg676GymUPZAI9sG4DW7kGMh/?=
 =?iso-8859-1?Q?Yx3cb4H/ptztEiYtTIzELGqHLkq17V8LyHWRazHAv+vZSlurXYEUg7MvoS?=
 =?iso-8859-1?Q?OHAi76ugRt6J4N3iTQ0uwJ0WkLZ0UV3VUk30ajjeQCHjEWQJaZAZEwrgwn?=
 =?iso-8859-1?Q?72ejCblQ8QZDBmZ/8ByN5DPcueKHekbWxusQXvXLQeEYtLIuKoMR6LkTkp?=
 =?iso-8859-1?Q?un8a/8oxk/waAnKI/j8jqhAxCz5tgqVj3SQs9ZBu7x7nOfgZ8QuPb8TPlT?=
 =?iso-8859-1?Q?gVIA63I+dZ3ASU2zOkTRMm8vWolzWv/+ky6/5X+LhKtdmYX+ULeYeRDtwz?=
 =?iso-8859-1?Q?87Bkh59K+gRCpSeeMxEyGmhbu9+Jyg8lyF3IiMFWDlenId8l1KrvLCWetS?=
 =?iso-8859-1?Q?sxN6lb3AJVie2KqQT6mk9A+TvR+VLgRngE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1RHdoNsTCYdtx9CfuUu30omWOV5IAn4GWmL9fZ+mzMU7NoXanH9r/o10pAm9rCl1s1zrnejH9siaBgDRC/UjOY/SA5Fm7HLc7U5GxDmFf2KXhns3BxFM++lh49wa7MpRmlDIMkJH3EKnFkZpshQqJ7S1gXoHYTa9dkdvQb8ExeF12pRXZ681ZK6I6qm8K9ejSt+lZU4ZBnwRuMy+Z/418P+jUxbPjFzyomeAehV1/D+Pj3+du/MQIOLP2/8NK5SuoxcBY4TUehPAxarPm8PpAfjPNJgNE112zEAqdrqPa7zNJo+Wr1YQTsU0V/lt4t9a73MEQSW7rzeMj1AauNZfPjTSZFrAjoqfyVw57Bi4xoYqpGrzPv0mooJBoRu+I0F2pd9Ur9l1K5K9pnc8aVFY0mJ28cMp4XBOgZsS/Ya/rwTwhCa0UJsp04hHxpyZmwStqG2rBvtXt2C9BCZ4CFr/ZatTtPGzzh9mlhIgMqf8o7zRydzGSkBaRFVwUEgIYBmYB2mnbi/N4APTa0GpLUCirpulH4QNX/FSH9z42a1XaOE9cwYCO5gXOeu/Z9mrCICQPgzPWoPyJNHxIJVEbeeNRkd6p9Pj+zEWBptI5IMQLaEAiKi6FZUEEXS4I24krcIqm2xklS05IyH7Yox78Tngc3M7caZOP9F+tud17loXJsxzJUmtt1jHsKe/RAcC4PYxy0ukOEBSd2MonEnUeRztcOtGdDlhoA1NVwmv393d27xzQWleX8BPjsIcDdbNoXGyes5mr6KLYVmaBX7X5vF2EC7aaa+yX6Ppv0L1CO9ABCUMyWb4yO0EpIWauivgCApwefh/me/DQOS2IQZpZ3hz3SR8osH4aQpY/zCwgdKSzrFMpSP5TsjIfm/8swSYWIqo
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9041.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee06e60-9469-4a92-e973-08dba4199430
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 20:43:16.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPEndfn+wvTkxP1DjdzDX5Is04Z+wuV7e4ieJQJIbPL40mgI92qoBgl1Y5RIA1hs+7R0HFQvterscJTQ9zE4Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
X-Proofpoint-GUID: tRk-WFjICJxUj9MHFb1GOPu3EG-2Zp76
X-Proofpoint-ORIG-GUID: tRk-WFjICJxUj9MHFb1GOPu3EG-2Zp76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_14,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=882 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,=0A=
=0A=
> On Fri, Jul 14, 2023 at 11:39:49AM -0600, Rob Herring wrote:=0A=
> > The DT of_device.h and of_platform.h date back to the separate=0A=
> > of_platform_bus_type before it as merged into the regular platform bus.=
=0A=
> > As part of that merge prepping Arm DT support 13 years ago, they=0A=
> > "temporarily" include each other. They also include platform_device.h=
=0A=
> > and of.h. As a result, there's a pretty much random mix of those includ=
e=0A=
> > files used throughout the tree. In order to detangle these headers and=
=0A=
> > replace the implicit includes with struct declarations, users need to=
=0A=
> > explicitly include the correct includes.=0A=
> >=0A=
> > Signed-off-by: Rob Herring <robh@kernel.org>=0A=
> > ---=0A=
> >  arch/arc/plat-axs10x/axs10x.c | 1 -=0A=
> >  1 file changed, 1 deletion(-)=0A=
> =0A=
> Ping!=0A=
=0A=
Thanks for the enhancement!=0A=
=0A=
Tested-by: Alexey Brodkin <abrodkin@synopsys.com>=0A=
=0A=
> =0A=
> >=0A=
> > diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10=
x.c=0A=
> > index b821df7b0089..1feb990a56bc 100644=0A=
> > --- a/arch/arc/plat-axs10x/axs10x.c=0A=
> > +++ b/arch/arc/plat-axs10x/axs10x.c=0A=
> > @@ -6,7 +6,6 @@=0A=
> >   */=0A=
> > =0A=
> >  #include <linux/of_fdt.h>=0A=
> > -#include <linux/of_platform.h>=0A=
> >  #include <linux/libfdt.h>=0A=
> > =0A=
> >  #include <asm/asm-offsets.h>=0A=
> > --=0A=
> > 2.40.1=0A=
> >=
