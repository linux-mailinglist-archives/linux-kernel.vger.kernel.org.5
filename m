Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAEF7E9DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjKMN6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKMN6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:58:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705BD63;
        Mon, 13 Nov 2023 05:58:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AD9TQqC020971;
        Mon, 13 Nov 2023 13:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KyGnGgCwVv9kdn6EPCURIaPE//zT3iPJ1b1KVp3VXxA=;
 b=n37EHIx4560ewoDkWxa5NzY1sk3qQG/bJ38SyY2/GfocyIrXBxizL1ZiPHLs/QgcYFV5
 NrgzYcTTqy+IgsMvQoK0fhWqgCQPgYX0rfDhoMy3YdzTWzGdiIeyNk8d85QOO1d7GI1m
 +8us2UNx3R8Rk0rFSpAVVM8+fgXpd4p9SPPdSGYgx24Aer7e9g57OqijMiV90wRKYBkY
 7iJ94PTGcW/ERMmnysf/cVR4yJESgosiPFSzcTic0BSzmPC5gaN6cDnOyWNU13cP3QKl
 UYQysj9WC4mmlt8m0mGUlPWLuDE22AMF9Aqxx8i9FVWIlS/dFZQ8Cfp3/EmgtsD+CoF1 nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd2tky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Nov 2023 13:58:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADCgZXb020841;
        Mon, 13 Nov 2023 13:58:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxgypsub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Nov 2023 13:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg2uhpWH9zVVQoLe1rLBX6QDJKqT9sifJcHA0k21KskQypDZWimNn7QVYMJBSxcVc7o5pwwQN25fT2TjN96YGBMh+iAz1wjBhq6XAs0f8T/Rsz6l8iJajPPbDKPKQvrq9htYCYrL8CBHayveVulRSrz/iir1HOP5/iOA+YPlmksd5ByTw4owLhSJhd5CjKeel10vCbRpPJrY10xlnIPru99outy9Fz5bTgI9opijkmEh5j/hkwY5IPyNWnTuI8HQZsezXh4HtSbuz19dBgdjhKa34ORQn8RfaLFIWFC9cWeLw/0DIDvUGcMeClw414Qu5HxBolpU9fynMxjQyUhApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyGnGgCwVv9kdn6EPCURIaPE//zT3iPJ1b1KVp3VXxA=;
 b=OKJ9d7GE7wUWshiqZT/TAKfT9p2XCyKqQ/H4o8HJ2oW9wAFZ6w+xo+ZFhQ1claK9ScHYny/15XF1t0qWpqH1HlCl9CCqhfZaiTj3LulYuvVxG8LhK247G7nU91rZOlBCTN8ErD196NKFRztlsiMyoLbayfbk/T3hOIZ6guvViNhLYwzvZD6ZNuVdpOAuZLy7+9ZoQ4crWKTIH781lzm0H8jIGgliJqxkOFPg0aeR7xv8cdtBqYe21/qBCtu1hh3/zhqEGGbNYJadomETSUhk8CyyXzV6O4eyhCLYXZyoNf9lnLb2cbardtc0p1Oqh06XO2KndI0xOECBhHgHSCtkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyGnGgCwVv9kdn6EPCURIaPE//zT3iPJ1b1KVp3VXxA=;
 b=x4f1wq1msEZ12Bj1ZPO8kzadEb5PeXMVs0JNupJWP7GqRrCeCeD/FEQTRBIIHwMhxjX4dyYo4jdMEf8911JIFkkRQOVEKRt6+xPfg6+NKOF95pg7C48gzDB7aN2EvVpXKN4ziZSyqBwI2SorEtrVdZEob003J2fpgvW6OGUOFUA=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5076.namprd10.prod.outlook.com (2603:10b6:208:30f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 13:58:07 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 13:58:07 +0000
Message-ID: <c3b821fb-5df1-4c58-99bc-f3e99a6d1d94@oracle.com>
Date:   Mon, 13 Nov 2023 19:27:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        vegard.nossum@oracle.com, darren.kenny@oracle.com,
        kernel test robot <lkp@intel.com>
References: <20231110142921.3398072-1-harshit.m.mogalapalli@oracle.com>
 <20231110142921.3398072-4-harshit.m.mogalapalli@oracle.com>
 <211e6c1e-9bfa-ac29-b6ba-e198c4f36688@linux.intel.com>
 <fb97e3ea-1bee-4d7d-a8d4-dd76107f75ef@oracle.com>
 <1b58df2d-b444-ddb7-7533-9911d35f8f7@linux.intel.com>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <1b58df2d-b444-ddb7-7533-9911d35f8f7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::11) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 799601c9-1f47-4db1-1cb6-08dbe4509056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcWGmULXYSn/M5OY6v73NwhvpMs40DP5cnxbowM1iUNExl2L13NsrlnwkQ8HpQDy9nibbVZfuHxdEMtPAFacXlq9+YQmcTr00yxZQm+OkUDYgr+PAJ2D7HBV9sXxAtqOFu9CslYPXZz7UkxhaLpHul88gq2b18rDQYzRwmx+tm1OMnN5idlMjf4bAifzHdc8hL1KIDenYJO1ufc+KpaabcE050i29PBg3weHmRZmybdZ1IpHwyUHUc0IGo8kbrGooYUVJ0eHYJH1ulyfGcIglTrp44FtOoe7rNxEFBE1fdsGvxEdAIoXsMUm7MimLynBvKg0RiM+1oyTZQNpCcyDpUDmyV3GfyvuAyY3PyJC1XnR6Z05GCFIbNaSsB8by9gImdsHLx8G9ta3ugpm5q34kI4vvz9TEwOSS3ifYnM5ct2kraY+6uUx1f67cO8R3BYzA6JLHOzPAhVjI3qRxHBjO7+QhPOVzVx3dTCqn6I6wJYI/XdR6O1Ebelx253YXK7bYlBXXj/lV6eUDHfR9vcj7aHKSZEKrkQm4KHA2rVdoYONwYqRRJqrcpPIzVSjKH88ZYyl35JXeRrnUwcVivZmV787yZjE7+eF09WCuCIMGb0K330kXcXaxnwjIVYUILCdnpu5b0vBegOrBlCB96H6fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(66574015)(6506007)(53546011)(6666004)(2616005)(6512007)(83380400001)(5660300002)(8936002)(7416002)(8676002)(4326008)(2906002)(41300700001)(6486002)(478600001)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWQxU0FvVTBYNUFFSENxM0NkUkFUZ3VvMnA3UDNXT2FmSkVWMXpSSmVzVHFL?=
 =?utf-8?B?bW85SENuVGFRemEvalprRUw0anRLOGl5c0l1cnJybytaN2hSZVVMcHhKUnBv?=
 =?utf-8?B?R1l2QnkrUndlM3dWOHdKRVY5cnNOYjVtWHppdjA3RE1xMFZXSkFVdVNQR0Vs?=
 =?utf-8?B?SWpFcHpnZDZBaFJMRllxOWxpTC9KMERqa2FsYVl6aWlDemh3SG55WU5FV3FO?=
 =?utf-8?B?ZGJsTHMzUWRzbyt2MXNFbVc4MktON2ZUVWROdURuaEpqaHdpRVZLY1ZtUlJ5?=
 =?utf-8?B?RSsyTjMwRXh4U3VaUEZqakczMW4xdG5mVXhacnN3L01PV2QzellTRGxMM3pU?=
 =?utf-8?B?NHhsZGRIMWovemlLQTQvTk8wKzk2UlB3Nlc2eWx3cXd0YzYyNldvN05vQTM0?=
 =?utf-8?B?VklWMktxL3Z6ZGhJL0NuSERKelFJOUJ0UHlvSE1iSnRJOC9CcGtTYmxKSlZk?=
 =?utf-8?B?dW9JMXpVWkdWMWtsY29TVG91MHZyeE9Jcjk1Ly9zaWM5L2dQemFVYzJxS1Nu?=
 =?utf-8?B?dDJQZWtYOEF2aGxVQWNBWC9LSVllQ1pDTHJSMjBqUzZ0V3BsZUluSy9DNnF6?=
 =?utf-8?B?ejcxUEJ4TkpsY3RrYW1sWFVvZ0VVZUNmKysvQ1Z1Sk4wQVp4NEJjMXdBNW8r?=
 =?utf-8?B?YW4vV3h5djJ2VzBYMjUyQk42VzRMU0RoZnBvZU12enc3UjJBT2tGQUVETkVh?=
 =?utf-8?B?RFE1ajIrTmM2dzJCb0pmQS9rSmluQjA4c2J4SVJYQStGVm00ZHV0UkNjUDE1?=
 =?utf-8?B?YWVsZWM0Z1BHY0xnNUxpWFVwTXBIV0dzazBrOUltZUNxU3pPejBQYWlpTmNi?=
 =?utf-8?B?NndqT0paZGliZGdhSEM2VWR3U0VrSGM4MUlYQU1oSGgwaWFYVVVSSTNJQm5T?=
 =?utf-8?B?OUpyN0hBYVBRUGVuTXZ0SVVKemZJS3UxM0pCb2I2dGYxQVVBaUZ3N0FvdWlv?=
 =?utf-8?B?RW9jeGx4ZEgxR2tnNUgvVHBGLyszR2NlWlM0RVZlTmlmUHF3aHoyNGVGUDFi?=
 =?utf-8?B?NWZUMjRwMjl2SGFJN1lSMVZwSW8rb1FWdjJEbjVPcmpuS2RGU2krZXdVSXh1?=
 =?utf-8?B?Zy9WcEhUT1dLdXBlSWYyOGh4OTN5OTBjVDc0WTA0c3hPOWZmVkJDdDdCTWRC?=
 =?utf-8?B?K1ZMREh3WkROMm1FQ25WcUtVOFdFVHJNRTZtcU93VC8rbTdvSXdlMUJScG1x?=
 =?utf-8?B?WFVjWURQdGtPWXpmQzZrSEdQWGlRTUJEaDRteGFzYlNYS1RkWEUvaDlPU01I?=
 =?utf-8?B?Z25zYVoxNXkycmhDRDB2ZlJpZGpnSHUwbzB6SVk3K29heFVYTERDcGhDa29i?=
 =?utf-8?B?bEFDUXoxN1FoUWJBdmFreGt2VW5OeVBFTTFyZ0QraFNmN0Y5YnFzUjFmcERL?=
 =?utf-8?B?VW0wdHczVjRwaUMzdklxbmY2OExCdzhydzdmUlFHazZSampFOStTemlCMzlO?=
 =?utf-8?B?OFNkUjd5U3FYQzdVU25xYklOSk40dEtTSlBkUnhMazVXd0RzTlBYNFhWbWMr?=
 =?utf-8?B?N3JTdzBVK3luQjczRUtUbFhySmRDemcvWkkyU0pYVGp2V2RoYzVDcjdkZEpG?=
 =?utf-8?B?aHE0ZWFqV2pUTy8wZmRFeW9sYWJIa1BuUFRYVWQ5bEI4cUlZNTFJOERkSlBH?=
 =?utf-8?B?b0ROSkJ0eFBPZGZ2VTdJM3RPZm9HaW9uSG1RUUNMYm45ZW8yRHFmcC8yWDQz?=
 =?utf-8?B?NHZPa29YOS9GcDlUZytSRXAwMFduSFNZQmZlZXFwYWtHUzdoQ0ltUEJ6Ty9I?=
 =?utf-8?B?RENNNG44V2FVQXdUU0ducHBKT0FROXh6ZFRMNll0ME1Nd2ZxdmM2VlFaMGZY?=
 =?utf-8?B?eUJJR1FicnNjK3F2T280Zm9nZHRXdXZ4THoraExQOUVFV3Z4UjBWSlZrRmJU?=
 =?utf-8?B?RHhKRHp3RUVaamZYZEIxVjZYL3RWM1RMckJ2Tk1iVXEyTjdSeU5BcXNYVDJn?=
 =?utf-8?B?RDJyZUFBNkRIdDVQSldkVWRUZnQxMnpGMExsaWQ3T25SSUNhaEhuU05ITHFy?=
 =?utf-8?B?akFodFpBWGFRM3BlM0dIVU9LVnlKODVENUhlcSs1TnBKZmUvWG5CSFhkaDkw?=
 =?utf-8?B?RldEZ0NOK0ozMVhROHMwQjU4ZjNnV20vaWU2d3lhZXZkOU9vMkQwMzVnNWsx?=
 =?utf-8?B?NlIyYTE0Znd1WGV3d1dqVGMwbUN2cEZXdFJvN05VdEIyR0RlQ1JRNHZTZkxL?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cTBmR21wWXhpOTlQVG5nVFRWLzUvRnk0TFM5L3J6TVU0WkJzNXJqS1o0TkN5?=
 =?utf-8?B?QS95R2psakNxRW9RbURvS2U5Ry82MnFicG1kMlhaTkZOYUU0QVYzemdiZU03?=
 =?utf-8?B?LytWUXNaR1JlcDhDbVBOT21iSU1sZ1lFVlYrYk1BYjNHckc4K2NrMFZXRmI4?=
 =?utf-8?B?d3pZTnF2WE9TbVJHVkNOekYyZ1FGKzFDL01Fc0tkZlN4WGRIM2w5d1N4SVdS?=
 =?utf-8?B?eEhjVC9PbHJQaVFNQWdHT1MxdUpRSmlxaEJxQTE5djRSVjArdzgxNWVwUDNZ?=
 =?utf-8?B?dzQrSnliSGVkVlY0N2o0UEtYNE1jWnpwdE43RFM4WmJmMzcra280VURuZFNl?=
 =?utf-8?B?RE1PNjdpeWlpenk2eE9OakcxLzNBSm5aZ1lZUGpSVnZTSDBsQTYxM2dLRHpJ?=
 =?utf-8?B?ZWNyb0xqalZGeFVSTGRHY1hCak9SVXhnY2hJbk12ZVU3Z0ZoS0pYMnRIZ0dn?=
 =?utf-8?B?QVJVSHBNRUpQSExtZkNKVGRkbkhEV2R6UDdRMWNLSHpiV0tTTU04S0krb0o0?=
 =?utf-8?B?Ni9Ybi94ZTNVK1lqT3Y2UzRON2tzSDFkTlI4dHFEK0Jrb3BzYjc0L0ZLVWZM?=
 =?utf-8?B?bzhyUXdQTDhETUtyM3EzT2IyT2IrUEV5WEIyR2tNcUc4NzBhUEY3MG5qUVd4?=
 =?utf-8?B?Kzd6a2RXMjNVTUNyZ2ZyaWNtQXpmVTZGYUljY3VpdE9xMzdvK2lmZWZpU0Ri?=
 =?utf-8?B?bXBSZDQveW9vKzJ5UDdmdC82MFZ4bldaVTltem9EMkFueGM4WWVnenlEWlJN?=
 =?utf-8?B?OWFCYThBbWZNRG40Nkk2NWpQSDZsanhvVUI3S0k3YzNZOEg1ODNFQ3RuS1FF?=
 =?utf-8?B?SDQ0T3VOa0JUYm11L2tUVkNRU2ZZRHhWSGpJQ09ldUxvZ3N3elE1cE92WjV3?=
 =?utf-8?B?U2lURk5LZWNILzlSRDRBVEJWVllCRmRsbjJQVmV3bmdhcVVFNTRQd3pOT0FT?=
 =?utf-8?B?U1ptaXdndnkxYWJoTHNtSHRISEoyU2xLd0QwMnFCaHl6aWg1R1U0RVRoc2lp?=
 =?utf-8?B?SnlRbGRFZktQcmVaVm1FQXRMdm05aGRYU2hxR2lSelZIZmNXZFJVMlBia216?=
 =?utf-8?B?UFNuVkRiRkN4OUdZUWlFYndKTnNMcmpvUy9BckI0eWRIVWQwenZ0aEJUZDdD?=
 =?utf-8?B?c2VwY3AzVGFRenR3VmtGK0tBN0laVzVnbDJzT0JPUDl4Y0ZObUlLamtKSFhR?=
 =?utf-8?B?QWhndDBmRnEvMjZadWRMWVNha3EyTUo0S0xra0NHQ2tkZ1NpVm1MeUthamho?=
 =?utf-8?B?NEpncXB4blNoK2dKSGtERW9RRlhRWGJPYmFtYmJsaTMrTG85Zy9Tb01BMWtu?=
 =?utf-8?Q?n68QkWh1mtSmf1otk7cgpEvy2K1a5dNUe7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799601c9-1f47-4db1-1cb6-08dbe4509056
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 13:58:07.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4/aPKzm0nijgsxenrVu8jgb5uiycypEU50JNcsSeDpD0NxIvf/kcExs94bimOLfO3yGDfW2YDjDMHOvRIpORLG5+6UZY55iZ9oocXkPFZ9846m3SQbj6SE6iWo+Rfvg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130114
X-Proofpoint-ORIG-GUID: kvRgy_5aB0YUXMvmq40MCVWDlvYmskoO
X-Proofpoint-GUID: kvRgy_5aB0YUXMvmq40MCVWDlvYmskoO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On 13/11/23 7:01 pm, Ilpo Järvinen wrote:
> On Sat, 11 Nov 2023, Harshit Mogalapalli wrote:
>> On 10/11/23 8:14 pm, Ilpo Järvinen wrote:
>>> On Fri, 10 Nov 2023, Harshit Mogalapalli wrote:
>>>
>>
>> Thanks for the review.
>>
>>> This changelog needs to be rewritten, it contains multiple errors. I
>>> suppose even this patch could be split into two but I'll not be too picky
>>> here if you insist on fixing them in the same patch.
>>>
>>
>> Any thoughts on how to split this into two patches ?
>>
>> I thought of fixing memory leak in separate patch, but that would add more
>> code which should be removed when we move kobject_put() to the end.
> 
Thanks for the suggestions.

> I meant that in the first patch you fix add the missing kfree(). Then in
> the second one, you correct kobject_put() + play with goto labels. There's
> no extra code that needs to be added and then removed AFAICT.
> 

This is the problem I am trying to explain:

Let us say we do memory leak fixing in first patch:

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c 
b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 351d782f3e96..7f29a746210e 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -612,6 +612,7 @@ static int hp_add_other_attributes(int attr_type)
         default:
                 pr_err("Error: Unknown attr_type: %d\n", attr_type);
                 ret = -EINVAL;
+               kfree(attr_name_kobj);
                 goto err_other_attr_init;
         }

@@ -637,8 +638,10 @@ static int hp_add_other_attributes(int attr_type)
                 ret = -EINVAL;
         }

-       if (ret)
+       if (ret) {
+               kfree(attr_name_kobj); ///// [1]
                 goto err_other_attr_init;
+       }

         mutex_unlock(&bioscfg_drv.mutex);
         return 0;

Now when we want to move kobject_put() to goto label in next patch,
we should remove the kfree [1], as kobject_put() already does a kfree().

If that sounds okay, I will split this into two patches, (first one, 
only fixing memory leak; and second one fixing missing kobject_put() 
calls on error paths)

Thanks,
Harshit

> That way, you can make the commit messages more to the point too per
> patch.
> 
>>>> We have two issues:
>>>> 1. Memory leak of 'attr_name_kobj' in the error handling path.
>>>
>>> True, but not specific enough to be useful.
>>>
>>
>> Should I mention something like:
>>
>> 'attr_name_kobj' is allocated using kzalloc, but on all the error paths we
>> don't free it, hence we have a memory leak.
>>
>>>> 2. When kobject_init_and_add() fails on every subsequent error path call
>>>>      kobject_put() to cleanup.
>>>
>>> This makes no sense. The only case when there old code had no issue is
>>> "when kobject_init_and_add() fails" but now your wording claims it to be
>>> source of problem. Please rephrase this.
>>>
>>
>> Does this look better:
>>
>> kobject_put() must be called to cleanup memory associated with the object if
>> kobject_init_and_add() returns an error , before this patch only the error
>> path which is immediately next to kobject_init_and_add() has a kobject_put()
>> not any other error paths after it. Fix this by moving the kobject_put() into
>> a goto label "err_other_attr_init:" and use that for error paths after
>> kobject_init_and_add().
> 
> This is easier to understand I think:
> 
> kobject_put() must be always called after passing the object to
> kobject_init_and_add(). Only the error path which is immediately next
> to kobject_init_and_add() calls kobject_put() and not any other error
> path after it.
> 
> Fix the error handling by moving the kobject_put() into the goto label
> err_other_attr_init that is already used by all the error paths after
> kobject_init_and_add().
> 
>>>> Both of these issues will be fixed when we add kobject_put() in the goto
>>>> label, as kfree() is already part of kobject_put().
>>>
>>> No, you're fixing a problem in the patch which is not covered by moving
>>> kobject_put()!
>>
>> Sure, I will try to rephrase it to:
>>
>> 1. Add a new label "unlock_drv_mutex"
>> 2. Add a kfree() in the default statement of switch before going to
>> "unlock_drv_mutex" to free up the memory allocated with kzalloc.
>> 2. Move kobject_put() to goto "err_other_attr_init:" and use this goto label
>> in every error path after kobject_init_and_add().
>>
>> Please let me know if you have any comments.
> 
> I think none of this is needed for this patch after you move the other fix
> into a separate patch. Those two paragraphs I suggest above would explain
> the problem and solution (no need to have these numbered bullets or
> anything else besides those 2 paragraphs).
> 

