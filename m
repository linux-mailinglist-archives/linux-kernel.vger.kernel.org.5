Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA3C7D1986
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjJTXQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:16:35 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26462D46;
        Fri, 20 Oct 2023 16:16:30 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLYXIM005898;
        Fri, 20 Oct 2023 16:16:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Jv5BP/kfVRAIMXMTD6G9d/63klWdEUpYTuzBYS+MGZs=;
 b=mAYHp1/AY4uSVDYkdrAUnNkZxMiL+7FcJ/eJKsskrcZHXWRt7FeI5JO26oybpJhpfyii
 FPTdoVB3Llkkgn48sdROeIisVVBRsitw/ue0ZEKtBBj15hSYfliB1790R05Vb/hysebh
 3mMk9uJhYkTh8KNw9nl2dCiS6S1eaFAbXykBquhBQ6xy/L7Rq50sF8Yh6ftciEnTITQa
 +WhXZ0b7136EseJVWATXC1M0lUuD63jvbT0LvR3ZyrWYUn2rlnetzGekloPvOAdRNCFx
 jsezkV0u8doSwGy7YpyeD+AyFk1HjiQAPwQZkVrOiIT3KZC/Fbddq7p5SxM9Lx47tcUq dA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3tubw4uv0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 16:16:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1697843785; bh=Jv5BP/kfVRAIMXMTD6G9d/63klWdEUpYTuzBYS+MGZs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ct1rtyFSfvaCa29wAzCUUZVPFy66JS9y5IJutyD2l1Geb3xC2IjnVry0qv0dqDoNZ
         wfchbWEYDyEWHhZ1nw4tz+f+xTQJHBedYRjwIJ1MYmiOIkDRGjg/C4S4D+fU2Dp7T4
         p9reZtvDIC6517GWj9oGyG9vTeDeIYcVCS2KwdYawpmlPRbtcpssy9bpBqBi1qfJjc
         rjW9lfdUxptSKLlnqmSm144p3K3O89sOIG6opl46r4D9cOztqB0RgO56dy3XYV07h8
         +WHY2fkEidlDO+o7m5jAaL7mbUy5b+TYGw4hOxzAeJxaA8ZWMQEt1YTjx1w0z2OJPU
         AJvofA3HyDZTQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AD92C4012B;
        Fri, 20 Oct 2023 23:16:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 361D8A006F;
        Fri, 20 Oct 2023 23:16:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=bu7wYc6/;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 99C204048F;
        Fri, 20 Oct 2023 23:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDM2ue1AOiDS618x7KWW5Mkb3kuaWXHqzYKRkVhWvw4ZcEvUzqlldlWtnlvWyaxXAAPOmTf1dnvDVY0EsFx5+BL2YdQFqnREOTXnb98E8A688xPgM+QUyQnHd7ylnKCvQbMj5LNWWWTf+zs8M5EzWbGf3pU4amdhZuG2pxD+t7ogyTvHPneY+Bp5F6I/z0qSX97B7KryP1c9pu7xO3PC3LLoDYjpjVfCidcBEHMqYlo6burkyd48sp8XW7pFH85dBnJJuy7ykmaNbvdhGFuSKxTB/k3Q0UxmsGDJF/V3WIt9C8JIbWOtuLKRtYWmf9E3uK/D+TLnvk1DvszT7g6jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv5BP/kfVRAIMXMTD6G9d/63klWdEUpYTuzBYS+MGZs=;
 b=j2HrFiGCEbrLF9nv4pSxaJnHByWlJ5yevcpeNn2Jxqx1jqEFzrttCnxudLQMuVxrT+XTPJZAvld5hHx+Hy7SuBhSIwB/FmOcqQFxFtewYX4xtiDPvWfe22lpsKN4Hoog7Dq1x9T71VN9Qc6C2ZRVUsCA/awO9YicH4iKduTVd07oRc/ldQY8X8BjMKjxYhp4eurOhEQwJ006WlzkX1ruyCpMK19oX1TA9t2OQAoeT1Y6rPL7Xi8AZrK2O6znV3n9KuKPA3/4LmAWWQkqv8+DwW5Vhr/OXqMpvwjzXFZhEU8g9J+GAfdrFpbVuoXblMKzi/Xn73ZhWptVizj2j1cb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv5BP/kfVRAIMXMTD6G9d/63klWdEUpYTuzBYS+MGZs=;
 b=bu7wYc6/LeHpLqGvIXwmpVwh7Rp1IpBEDA6v25ROdmRlfLXArPNEDwJIm8lQwlOTVdbJ6POXkLz0uG+fd4SDBj0tET6sYUWbyiAk1a/RaSp81/R4IECC7Vd0jTdZCbZYVbL6kp+ksjCfBol3vTgGcuw3oCy+wkyoUrTeDGU2GTc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 23:16:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b63e:67e6:b5fe:a8cb%3]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 23:16:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Piyush Mehta <piyush.mehta@amd.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com" <git@amd.com>
Subject: Re: [PATCH] usb: dwc3: core: enable CCI support
Thread-Topic: [PATCH] usb: dwc3: core: enable CCI support
Thread-Index: AQHZ/ZcFv/K9cjDJNkagq5mdTaNI2bBTW6qA
Date:   Fri, 20 Oct 2023 23:16:20 +0000
Message-ID: <20231020231615.w5m2w5bknblpkhyt@synopsys.com>
References: <20231013053448.11056-1-piyush.mehta@amd.com>
In-Reply-To: <20231013053448.11056-1-piyush.mehta@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: 00cca26d-38a4-48fd-8941-08dbd1c291f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z51j1OJif7PY9i1WP3NDEingc4Eog2/j8SCSOwQeuNVRpnJLDkkp9XAMdecKbn5VTN/F7rb7Rr5AUJWJYEfR0+edlLLUMKrsb2565+w+rqJfXkfbmHzI4Th4ZJL9iyxcsD2qZy4jYJ97WYVl0lQgfYP/Qogrh7r9vUziPDFp0wgxIdDFZUb4t0lbSOUMbRVq7gDMipNDQKzqut4r5UX3wikTyiS8fOk/XxeLTh3kgVPyDCRwsCVpQKub59ydxWNM1/hSuUmx5RXWkAhyBpqAGkp7c/aaXnUlhAYZ+s1mLNOi4xyz3E1g6kZlE23fWyghg3ekpWF0pP5rIZyc0l2v+AkZFcWTt+0FtLG9kxVIFBtfkSvBC2HTmJtXJ85iQG+cEQolZ9iSs3JerUS7m6JmEd67CHmz1obsYNaiCjjqVnFcVRWtj2znbRhzYG3QEsasZ6fVa1ggb65oJoEBE3p3HUKm3kzp9aXmr5WEk+E7lXC35R4zyJNMvpwqy27aaimD+al+5eTnKGwgsEcNC+oEMwHItiu8zMj9zp9MVFk6T1MM37qrfVlpEmMliiAENp4E6OprOxXfxpA7FFIZb6jvs0sKYfeW7rHOVyvxHDOJmpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38070700009)(2906002)(38100700002)(6506007)(4326008)(8676002)(41300700001)(36756003)(83380400001)(2616005)(122000001)(6512007)(1076003)(26005)(8936002)(86362001)(66476007)(478600001)(66446008)(966005)(66556008)(6486002)(6916009)(66946007)(76116006)(316002)(71200400001)(64756008)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blI5VEZFZWFYYW1LRDgvaTJaUFFlVHQ2RlU4N1VjWWo3Y2ZrYXNrbmpYcVZW?=
 =?utf-8?B?eHJzZW80dFEyNFJIVU1TNTJDSUdBU0lsNnd4RWNyaFVWZTBJNDFVNXdia0cy?=
 =?utf-8?B?R21rZmNlZWhmZ1hTNUpCc0NVZGIzb096NE9yRFRjQVZRWDU1ZUhsQmtjLzRp?=
 =?utf-8?B?RFN2ekVaU1VCa1FDemJNOHo3SnJLc1lYN1dTL2phUVo3TlZlZVdsTENpWThk?=
 =?utf-8?B?aUlSRVAydmY5aHdHblg1TituRkd3T05wS29TQkk2SFliS1U5aERROXdFY2gy?=
 =?utf-8?B?MWxXWS8vM2hUcUtMOEtxWUtmeXNXVFhxL0xlOWt6eTVHSUZUM0xDbWhmOWhp?=
 =?utf-8?B?NmJVNUFldlNET3F6VlJkbjdJbWhUUTB3REYvazBnTjh2Z1hpWnpmYnAxSlRv?=
 =?utf-8?B?SW5wL3Z2dVYwK2Njci9CUzFNdVVCbmV5T090Z0hEQmFBNEdZbmJGQTlBaS9o?=
 =?utf-8?B?ZWJIeXJ4K0VLQ2wwQ21xTk9SQlAvdEdEZWRmSW5SWlhwMTNrRXNBYTZIRW5t?=
 =?utf-8?B?N0pocVlHTkFHRHY4QzFUSFZ5WXFpNlFQWThXK0YwL0Y2RlRzWG1QZG5nZmp4?=
 =?utf-8?B?Uk45QnlQV0ozaGxIclN1dFN6b1J4T3Z1K3ZDaHdhTVNqVlVZeHFyaGE5RDBq?=
 =?utf-8?B?MkhLSkh2ZVlJQVh5WEl4ci9kMGlzNHdWSnM4U3oyTng4VWlURDI3UThWVG1z?=
 =?utf-8?B?Vm5UMEVUZ1hVclBnbE9GM0pNT1RJdExEL0dkVVJiMm1yTW9OMGNvc0Y2YkhO?=
 =?utf-8?B?M3pBSzFESnJxNUdoNkJCZ290SUZBakRpNnJuL3RORUVyS3RLODFrSTMzd1ZW?=
 =?utf-8?B?aUdYNERvTGxyWkVHSXpCQ2tSamR1KzMrQW8zQUVjdW43Yy9jNDBIRzFUQmVm?=
 =?utf-8?B?N3FVMm8xakZaUFlOZGJZbUFVUzZvdUswNE9tQ2JIY0xJRVV2dWlFS3d5K2F4?=
 =?utf-8?B?ZXJKSTFMNXcwMnJSK3lIeWJZOUIzTlRYbTJWR0Y5RnBnTWRPVXV5MmJrMXpE?=
 =?utf-8?B?Y09ObmRzZzJ3NWtWcGwxWlFncEFOTHJGV1VvYXFOZ2ZESlpqbHRkOFgrQXNq?=
 =?utf-8?B?TU5KdGw5RHROc0Jad1BsVUM4Z216Z3JsNW5NR2pUMkZsWGdtMTdNYjhJMytC?=
 =?utf-8?B?SVJXREdKNFY3amlsbk15ZWZNdm92SGhCMjJyZVlHekJkWnppSUhuZUpuSXF1?=
 =?utf-8?B?enRtMnh0Smk3OWtXa0hzU2l1cldFcmJTYlV5RnQrLzVzbWI1a1lSbm1VTDkv?=
 =?utf-8?B?VEdsNm9hK21xTWRoSklSb2NjZDU5N0lxU003R2s2RnVCemszdlUxd1ZiK1JY?=
 =?utf-8?B?ckJnalFrTWZ3T0xtYk1lMDdHa0ZVZHVZQXFETy9Ia2U2MjFUTEV6QlBZZkpj?=
 =?utf-8?B?YWxrZU1yQWE4RmJPZ0FqM1locUpGSjdLOVU3MWVwcWJuVkpWOEhha2FTbWJF?=
 =?utf-8?B?bEhxQkgydmp1N0ZnNXphYXpxYlNkMVpjNVJpM0ZVa0NtKzJBRkp6NUNyRTk1?=
 =?utf-8?B?NEQ2NHJuWi9vTnl6Q1I1RmlVa0gwakRhK0s4bzMwUXJIUzErcW9IZ2U3V2J3?=
 =?utf-8?B?akw0YkMwRUhLT2c3RUt3MFZWWDhkc2JPcDM2QjI3THhiOE5oQ3ZqOVowbjVO?=
 =?utf-8?B?N2h2UGE0SStxSVF4RktFSDUzcGpsZk9tSS9GTHVmQVY4YkFBcUlaUmVmRUd4?=
 =?utf-8?B?R09uZXE4a2szQnRVRjVrMlFsQXpXUVZ4Y1VseGF1UHVHcHNCZ3IzSUxzSUxU?=
 =?utf-8?B?aVlUSmkzRDVEdUplNWZCSUtWK2NXcXZxTmVvNXhtU0ppMENMcktQdjFQRFp2?=
 =?utf-8?B?TEhPODREMFpzVTZhTTRsUUE5SlpQRy9SQlBPd0prbWlpTEM2Mk9xazd0VCsz?=
 =?utf-8?B?a3J3RkptYVVUMkxacEZaNk16UjBBYVBsaGs0MEQvLzFUSDZpUktrSFBxWnNk?=
 =?utf-8?B?dUJsWG9RLzhBaXMrSE8vRzNwTTlmbGdiU2x6REJRL2lPcXdFQlZ4ZTNCenpS?=
 =?utf-8?B?bWRPdFRjQ0RGcnhHdFBZMXdUenFvd3RGZDBNYzhKZDYrMEFjS05VeDAydlZF?=
 =?utf-8?B?UDRPMlNSbkY2QVVWRm9yZ2g5K21PSjdmTzZmem03YksralNtTTJNTXBqRlcw?=
 =?utf-8?B?M205WE5XWFNjTXkwR3dUZ1Z4R2NVM0VVM3l0L2pmWmFBZDJiZUpHUEZacXRW?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ECA54F967F3734BB7454DB18FA40140@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cnh9nlN8//4xCu46xWiFfS8NKt47z/+yKXIE4OgCHNCRRbexHNoZ9eP2atXoTcI55wuxi8d+5DDeUB9Qs0uLg+b7YkdHAXGEovVsLi5FB0QvtElfiXqtsWeNlcNCE+PCLOX0JJShxUrHsSAwFzgZTnHmmK0hmg2LrYK9vErn03qijhohHGE3ggTiOP4eeJggLUDXORiwn0SBrOgqaW+ef4c8RAOAPlcpiMnFMcLS49glBhnz/CTcV/ujDAWaN9xoIuPONmEmu5elxURC4NTMfAzr0Zx+aDJtBQh/3FFOq5QqgeNvJ6cTO1j0FPjrY+Mu2yheSUWYGgb3vWUCOWb5w068D7ePqXYxd5Mt98k8NywEkE7Yp8bQx9IHjRiW8KJVH2eqdAerY+2Xt3G1UVpDNmEuMADebNQpz7BPee9KH8nwMZbmbEoRVOpWL+6b9nUHUMgx+UIuJE0SUk3xRQtLymNUeswrKrfR1dGBgE14kxy8NpWdmO2viQFNYKZT2nCOQVlE4CBL9KYSZc+fo78JqNXIanjjIf39VjjheyCAVIdhjMyroMk2P7/XXd1PQiC/hHMej/sfvFBHJdxmxHhI8G25/IytVvvaJmi5F8wGPnxGs/BiBgqktZNrwF3B+rRXteFTw3PZLkKaDLKvobAOMOiNvN9isxJ9csWMT0wsVVt8TFSfRFnOmdBc2EnnGEyYbcj3YxhveSq4dlcZSdiIEs7wOe7fE0BKaoD/XN6K5qFW5kkuPF9ghGrHmeBfdJ2yamk5Bwg6Bw4sDqaKhhSx1Fm5bfpdjRiEaGJM/rjdvuK9hfdE9+eI0p0glDpUY/56X3fuZRoZRfi8RIcCkaWJrDzd4c8ptx++NKJ5IvLm8GJZmtcdqB2n0+z1cYqoiABY
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cca26d-38a4-48fd-8941-08dbd1c291f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 23:16:20.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRGbZJlTQMil5NpWlqBDP6aFi5fu/tyg4g94QBrZJXL33HIDmP/jmL0dmTfhd6zAQ4U2gga5MikccHI8aqHIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
X-Proofpoint-ORIG-GUID: V3prBvjw9EszHtiZqH_EyzWZYMdhz6DL
X-Proofpoint-GUID: V3prBvjw9EszHtiZqH_EyzWZYMdhz6DL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=889 bulkscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMTMsIDIwMjMsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4gVGhlIEdTQlVTQ0ZH
MCByZWdpc3RlciBiaXRzIFszMToxNl0gYXJlIHVzZWQgdG8gY29uZmlndXJlIHRoZSBjYWNoZSB0
eXBlDQo+IHNldHRpbmdzIG9mIHRoZSBkZXNjcmlwdG9yIGFuZCBkYXRhIHdyaXRlL3JlYWQgdHJh
bnNmZXJzIChDYWNoZWFibGUsDQo+IEJ1ZmZlcmFibGUvIFBvc3RlZCkuIFdoZW4gQ0NJIGlzIGVu
YWJsZWQgaW4gdGhlIGRlc2lnbiwgRFdDMyBjb3JlIEdTQlVTQ0ZHMA0KPiBjYWNoZSBiaXRzIG11
c3QgYmUgdXBkYXRlZCB0byBzdXBwb3J0IENDSSBlbmFibGVkIHRyYW5zZmVycyBpbiBVU0IuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaXl1c2ggTWVodGEgPHBpeXVzaC5tZWh0YUBhbWQuY29tPg0K
PiAtLS0NCj4gRFdDMyBSZWdpc3RlciBNYXAgTGluazoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vZG9jcy54aWxpbnguY29tL3IvZW4tVVMvdWcxMDg3LXp5bnEtdWx0cmFz
Y2FsZS1yZWdpc3RlcnMvR1NCVVNDRkcwLVVTQjNfWEhDSS1SZWdpc3Rlcl9fOyEhQTRGMlI5R19w
ZyFjYkxiWUxrOXh1NTREWk1raVRRek1oZENhUEE0Z21JVkluZXM0WmVOYjI4QUkycGdlc0V2SE5Z
dGpvWmZXdkVfdDd3bFVkWnZZbi1QaW84V2pBNTVla2FsJCANCj4gUmVnaXN0ZXIgTmFtZQlHU0JV
U0NGRzANCj4gRGVzY3JpcHRpb24JR2xvYmFsIFNvQyBCdXMgQ29uZmlndXJhdGlvbiBSZWdpc3Rl
ciAwDQo+IA0KPiBHU0JVU0NGRzAgKFVTQjNfWEhDSSkgUmVnaXN0ZXIgQml0LUZpZWxkOg0KPiBE
QVRSRFJFUUlORk8JMzE6MjgNCj4gREVTUkRSRVFJTkZPCTI3OjI0DQo+IERBVFdSUkVRSU5GTwky
MzoyMA0KPiBERVNXUlJFUUlORk8JMTk6MTYNCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8
ICA1ICsrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+IGluZGV4IDljNmJmMDU0ZjE1ZC4uZmM2ODkyYzYzYWJmIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiBAQCAtMjMsNiArMjMsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9ncmFw
aC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9waW5j
dHJsL2NvbnN1bWVyLmg+DQo+IEBAIC01NTksNiArNTYwLDIwIEBAIHN0YXRpYyB2b2lkIGR3YzNf
Y2FjaGVfaHdwYXJhbXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJcGFybXMtPmh3cGFyYW1zOSA9
IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dIV1BBUkFNUzkpOw0KPiAgfQ0KPiAgDQo+ICtz
dGF0aWMgdm9pZCBkd2MzX2NvbmZpZ19zb2NfYnVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+
ICsJaWYgKG9mX2RtYV9pc19jb2hlcmVudChkd2MtPmRldi0+b2Zfbm9kZSkpIHsNCj4gKwkJdTMy
IHJlZzsNCj4gKw0KPiArCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HU0JVU0NG
RzApOw0KPiArCQlyZWcgfD0gRFdDM19HU0JVU0NGRzBfREFUUkRSRVFJTkZPX01BU0sgfA0KPiAr
CQkJRFdDM19HU0JVU0NGRzBfREVTUkRSRVFJTkZPX01BU0sgfA0KPiArCQkJRFdDM19HU0JVU0NG
RzBfREFUV1JSRVFJTkZPX01BU0sgfA0KPiArCQkJRFdDM19HU0JVU0NGRzBfREVTV1JSRVFJTkZP
X01BU0s7DQo+ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HU0JVU0NGRzAsIHJlZyk7
DQo+ICsJfQ0KPiArfQ0KPiArDQoNCllvdSdyZSBvdmVyd3JpdGluZyBkZWZhdWx0IHZhbHVlcyBm
b3IgYWxsIHBsYXRmb3Jtcy4gRG9uJ3QgZG8gdGhhdC4gTm90DQpldmVyeSBwbGF0Zm9ybSBzdXBw
b3J0cyB0aGlzIHNldHRpbmcuIE9ubHkgYXBwbHkgdGhlc2Ugc3BlY2lmaWMgc2V0dGluZ3MNCnRv
IHlvdXIgcGxhdGZvcm0uDQoNCkJSLA0KVGhpbmgNCg0KPiAgc3RhdGljIGludCBkd2MzX2NvcmVf
dWxwaV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJaW50IGludGY7DQo+IEBAIC0x
MTM3LDYgKzExNTIsOCBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpk
d2MpDQo+ICANCj4gIAlkd2MzX3NldF9pbmNyX2J1cnN0X3R5cGUoZHdjKTsNCj4gIA0KPiArCWR3
YzNfY29uZmlnX3NvY19idXMoZHdjKTsNCj4gKw0KPiAgCXJldCA9IGR3YzNfcGh5X3Bvd2VyX29u
KGR3Yyk7DQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBlcnJfZXhpdF9waHk7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+
IGluZGV4IGE2OWFjNjdkODlmZS4uYmQ5MzcwMjVjZTA1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAt
MTczLDYgKzE3MywxMSBAQA0KPiAgI2RlZmluZSBEV0MzX09TVFMJCTB4Y2MxMA0KPiAgDQo+ICAv
KiBCaXQgZmllbGRzICovDQo+ICsvKiBHbG9iYWwgU29DIEJ1cyBDb25maWd1cmF0aW9uIFJlZ2lz
dGVyOiBBSEItcHJvdC9BWEktY2FjaGUvT0NQLVJlcUluZm8gKi8NCj4gKyNkZWZpbmUgRFdDM19H
U0JVU0NGRzBfREFUUkRSRVFJTkZPX01BU0sJR0VOTUFTSygzMSwgMjgpDQo+ICsjZGVmaW5lIERX
QzNfR1NCVVNDRkcwX0RFU1JEUkVRSU5GT19NQVNLCUdFTk1BU0soMjcsIDI0KQ0KPiArI2RlZmlu
ZSBEV0MzX0dTQlVTQ0ZHMF9EQVRXUlJFUUlORk9fTUFTSwlHRU5NQVNLKDIzLCAyMCkNCj4gKyNk
ZWZpbmUgRFdDM19HU0JVU0NGRzBfREVTV1JSRVFJTkZPX01BU0sJR0VOTUFTSygxOSwgMTYpDQo+
ICANCj4gIC8qIEdsb2JhbCBTb0MgQnVzIENvbmZpZ3VyYXRpb24gSU5DUnggUmVnaXN0ZXIgMCAq
Lw0KPiAgI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9JTkNSMjU2QlJTVEVOQQkoMSA8PCA3KSAvKiBJ
TkNSMjU2IGJ1cnN0ICovDQo+IC0tIA0KPiAyLjE3LjENCj4g
