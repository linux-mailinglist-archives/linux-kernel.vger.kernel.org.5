Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6AD7B542E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjJBNhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjJBNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:37:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2048AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:37:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3928XrSH024037;
        Mon, 2 Oct 2023 13:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iv7ko6NMEiTionyg9Ud7w9/9XIbvRqhjD5pgK2OXykQ=;
 b=2IpkRc4UsLrqleKmmefLxu8pJTUFKgXtRPEP2k4PkL1Zp4ya71sV9lLcUfF42TD/8tMJ
 1NZQfZfcVzB87x8vDWwaN7d7TU/OOqPZFUtVr2pfgyds8f4mi0PuyMc0AmA3i3YtsQV1
 uOa/r2Em+m6U+JO775H/a4FbTvW8foPbI/YqUUPzaXgeAP9tms5BKK0enmJrFKgHyxIq
 DZjDFrtbEQpYCUFUh1JpwA/RXxpQyyr13maiBH8Dupm4+dvuHsJwO+LNyVsLoBpZOxAW
 fpbJYRKDNwZUgZzJ3mNpqtHaaJA5LSdAK06Y5WNgm54y4oHnrnHekwc4anMYgJrDCuzC ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbte6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 13:37:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392DBPKH002846;
        Mon, 2 Oct 2023 13:37:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea44jbpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 13:37:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmQNyFVcHZJMhbFyWHN+zpDgYPA1W9Xc2YxMrIGhsaAfqQC+ipaLCvQwjpjtOyqXKMgwe2G4ZSF4AiQjE8HfuuqYmD6+PNUrGvqkMo0qG5YlxXK4TNzXAq8rDzcdgXaywTna3BqfpbpqpQc2vrf2KpuCpK2aP+9KpDsgSMm5cqkee+vJdzHTPNIQ/mQCYlhN41IEUMTAdtg+gSGpxAXGyKBtQXT0+T5nqDAs7Ao2SUwJe+hKaEwaPduLaJQnacRGUWqZuEOy7z2p7vtWnpOq5i7XlmeMBvw1e4GwgArNEJgZzmd58m3iClbPxmpmwVuLbTiUvD82DQvoggQ+lAXhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv7ko6NMEiTionyg9Ud7w9/9XIbvRqhjD5pgK2OXykQ=;
 b=HIAu3NrR0x36WRjFwGhq6jDhpyWzQK7fh3DxGKXyI5uS2VHh6bYfR5P5oqcrKsUDQnvOytVJV78QRXuwn43u/um9ShVBKr2hpumt9MJpHdnkojFv5WbbSDb7RIjD1hO/VAN2V3BfaMgcbw8wmz3LpZ4kVWK31pgZCx6F2VxrcUQDO9NL9m45N4hf81K1Y70iIWdXjiryUhZLAH+Di7M00J6EzUXFKeibduaHnwC7elH3eS6WHMVv8qHNMsT+TzGZIMCSkpujepwSwLpXWGlJlAkYrHuhpsrCsmdFXhT/EhaY8pR19tmSbW0K9zopj6mVzy8vbJrnTRTDsQvNSPeSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv7ko6NMEiTionyg9Ud7w9/9XIbvRqhjD5pgK2OXykQ=;
 b=FvWzD1W1g6/UcZkGxikWqetye7gQgbpudY0777AI0k4MwUvVaqAskyZKQAcmXi/9SHjDUJe7xoIy47Wd/INFZX7OqpPIDfawfH+Kj6HR2tSrutB+HlDk9a/N8vVQYC1VgJAQM7mLxU+KUu39ROHWo4TydHGkOEuZ0Cq+luG01pU=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH2PR10MB4152.namprd10.prod.outlook.com (2603:10b6:610:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 13:36:59 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 13:36:59 +0000
Message-ID: <52f36393-c764-4b9a-b153-1d34126739b2@oracle.com>
Date:   Mon, 2 Oct 2023 13:36:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64/kvm: Fine grain _EL2 system registers list
 that affect nested virtualization
Content-Language: en-US
To:     Eric Auger <eauger@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20230925162057.27548-1-miguel.luis@oracle.com>
 <20230925162057.27548-3-miguel.luis@oracle.com>
 <c01525e8-0906-6990-19b9-df374fdb087b@redhat.com>
From:   Miguel Luis <miguel.luis@oracle.com>
In-Reply-To: <c01525e8-0906-6990-19b9-df374fdb087b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0026.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::31) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH2PR10MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 6051eb13-d2ef-459c-d5fd-08dbc34ca712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NL74C5360TizH45Jr9TVJDdhF/0r3GFayyFZ6bXdgy1xDCnnlEH0tFGOHNRGdgfNdcpqf3ECT7KR5HjcjMDTBgOxpuKtN618LCV8hHVOc32UKMasiEwqvQvo6CfJ8GOvnEQ+8VJg8QmH5JMh1rc9mVLrFn1LaKNoK0KgQvTFlasUq8QRhk/K3rBwMLMAXsfcK58hAMiXwkcUnw5K2SP7dOfFGoZRv6p+IKICcKyzqBQr3woix9axJNhZKRd2qQVWeC61pBCEI1056CZfvC2s+j5e547Uu+wr/PdGQhVGyAMQnIqgCRucCpPgPVcS8f/rXB+zvwyZ5SIc8OCjMdjNo73rOvJBcjVR7HMP/vZV9b3K284up6Oftfgm7dTSO/IeQgwkFwWWI/9HVSDLQbU+JC0rM4Fl/sMgG+PWyoZQJDgg5eZ3cAVVquPK+5W3tiYi/iEmJdgmPrKrvBRlQtZ0q1d8HnnMUlHv0E/sxjxFDIosdmeSJr3KorUAcD6+cu2ereb7JJzLSbIA+rS9wNasZOT9pwPg4gbMiPML4u/wyKB5uW834MzJXpqt9a65apfY6uGC5/bHc1eo4EdGqLXoFMP0Fcau9Gd9yoIxhAxgZWNfLeJoC4zxSNXNJ04+/FHmdq3LmNozp94mVxeOjp/KsQTvPYfKuM3TKEj27t9HY8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(66899024)(2906002)(6486002)(6506007)(53546011)(6666004)(36756003)(86362001)(921005)(38100700002)(41300700001)(478600001)(8676002)(26005)(2616005)(83380400001)(6512007)(31696002)(110136005)(8936002)(44832011)(5660300002)(66946007)(316002)(66556008)(7416002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWIxeU8zT0t5U2J4Qmp5dk9PVmx4SDR3OFhMdW1QTVFMb3JJN0puNjlXL2s4?=
 =?utf-8?B?OFh1QklYOXZkaU9UUW1abDNxRVVQcFBidGF1QWpkbFp4NGkyMmdVM2sxTERN?=
 =?utf-8?B?S3oxNjhhVTZTaVRSNElIVU82RHR3czQ0dUJRYXlIRkg1QlIyQXJtYlVaT25R?=
 =?utf-8?B?OFVXY3BsVWhxczRXbGtWdVlZbVdwMG1zVlZ5QTRkVlpRNEVqTzBiRk45MnlT?=
 =?utf-8?B?RFJabVQxTlZOdTh3NUZxTTV5TFZtWmNVbld0QlFVZXIzb3JhaEl3SzB5VWZo?=
 =?utf-8?B?cHZQOEhFRjhSMkxwYUwwREd3UmhzdGI1bnF4SmJSdG1pQU16TkNLbHdZZjVM?=
 =?utf-8?B?MjFuUTd2QndHNzlOSlFiZWI3dVAvdUhLQUkxNFVzd1ovMkJTNXZ4MlZUdkN4?=
 =?utf-8?B?dyt2NVI1SFFxUWhsSVlUeTNVODh3V0Y5S1gxZHh3ZU8zKy83STFlSzVuZmMz?=
 =?utf-8?B?L2VtMzFlN2t0aHhtd2dCYVZoTU56cUtCQWRtTmtSaUNVVVVvUks1akx5ZHgy?=
 =?utf-8?B?NDFvZDZuRWkxZTJJU2VPcXoxcTRPM25aSVM1SlZCMk5XQ1BXdTlyQk9hdHRY?=
 =?utf-8?B?Ri9HcldyVmhWVEZudTFKLzhDemllOWVodDVmS2owR0todFhEeFZVZXNpeE5i?=
 =?utf-8?B?c3h4Tml1TnNXTHFEcVpFdHJQNkZxaWZqQWMySE5qd2VOcXdIbllDMnRscWxa?=
 =?utf-8?B?NDBpSm8zbG5EaWVORUhtQjVEM1hudER2WjdmVUhrcU5Ta2lMMHZEUGFSWk9y?=
 =?utf-8?B?blVJSTc2eXlPYlNMWU9uUlJiT1BtKzdmNWJVVnAzNDNLbXRYTFd5R29qbGR3?=
 =?utf-8?B?NDA4UnlaS1h1aHIrUS9YNnNuQ2o2RWNpMmM3K0lOVVlTUjMyeldyc0dWMm55?=
 =?utf-8?B?VWFqSHNCRThiVUFaVGFsVEhldXI2SW5GK2pvR05pZ2ZHRTV4RnlkQ2dzL1dI?=
 =?utf-8?B?RzJuYWlUR1FPVXNUVHVrREdoZmY2dTZxNFJ5SzNVYnlvRHRHVmZ5SEZmTGxt?=
 =?utf-8?B?NW9kUjBFME93RVV3SDVuRFk2WkxrNXhSS0tMeEM3UnN5VXZhcGpxRjlkR3FH?=
 =?utf-8?B?WjZFZ3VNMm01Y1JJNDlSM3hQOUdveWp2b200QkpaQUc4V3NqNDFwMjVQWk4r?=
 =?utf-8?B?b29DS20yd0tKSm40dUx4OVMxRVVSVDN2UTVSQ0Q1RitGY1doeEZXMjJLMHNK?=
 =?utf-8?B?REhWTnBhM1AwMGIxRm5Qc3dmOUhaT2xoc1V1TlJ2cDNmV2pTSXlLZWcwRnRN?=
 =?utf-8?B?T2l0Z3piTExuVmdyVUlOYWY4MThPNFJwUDRaeG1ISCtZd1VYZG1BL0svVkRY?=
 =?utf-8?B?ZGtKUjF4MDQ3ZEJUQjVIbGlYMzlMMHdLaXdhcno1T204aVhoK2hYQjFZS2dN?=
 =?utf-8?B?emlQMUtVem15SHpjWlg0YThHNGZxUnRCdmJoSkMzdGkrVXVlSUc3Q2tFRHpY?=
 =?utf-8?B?dC9EUERCNVNCZi9zdWNxN3VNT0tqNTlmelIzS2psRU9IZHNkdkJQRVZOQWQx?=
 =?utf-8?B?R0FWQkNxUlhEQyt6c2Nlcm84dmdVbld1ZUY4YmcwWS8rUGQrbmN0WjRhb0hH?=
 =?utf-8?B?VTFNWGljUG4vQXJPVk9UcC9MTHZoZXprbnBzckRUZGw3Ujh1QW1Ra3RGMHo2?=
 =?utf-8?B?djZUeEJXQnBjbmVBdS9XT1ozVENPTVRWazZna0c5N3IwQmlneUNUU2JwZUtP?=
 =?utf-8?B?S2c0SWVjRldKeWoxTkJmdElTZUh0cnR2Q1hPY3NLcHRRY0JPK2d2QnVLbDFk?=
 =?utf-8?B?eHpzdVp5aDNmUVU0K01XQmR2amhQSmRqT1ZRcmJJNjJrb0ZONmpob2NVMXl6?=
 =?utf-8?B?aFlZaHJCODNnQlVuOXJkYlJOcjkyN2pSeTJRSlErVW4zd2hLYlJQMGF1Y2pQ?=
 =?utf-8?B?MHpHaVhJYjlDaDIzRzUva1VUSUhRc2hRMis5dVlGYlJyQjdzZ3hNQy83cGto?=
 =?utf-8?B?dzljK0dOUWZDNTREVEtJb1dOQXVHVjBySnBzb0lyMHh5ZHB2S2d3SW1QWUs3?=
 =?utf-8?B?SVV3VnZtR0dDQjlGQkNBc1hFaDRKUkI5bUhTWmRSaGlzQnE3N3NZZXZwUFJV?=
 =?utf-8?B?R2lMZ2Q2NFJKajFraUloQ3VKM1ZnbEtMck9hZ1RvZCtBZDhMS1daa25CVS8v?=
 =?utf-8?Q?zK34xAnm40yjFglx+Bxdrkrkt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NERoTDM0UXQycENGYVZSZTBtbWI0YVVXTHNrb3hFNmEySjQrT09TbU02UWNr?=
 =?utf-8?B?OFF0QXloazhkZGhmSnFsa2hBTnBNYkMyazhkZW9mZmh1SVFHOVRUcko4OTJX?=
 =?utf-8?B?OGY1dlBwTHA3cE9qc3FLdnVjcDFrYjFEMHRnNWZadURQTm12TnZETFczeVJN?=
 =?utf-8?B?U0xpS280Q0xqVkMwS2h2Ly9WVFNWSFQyY0RXYXZIVnVHQlpzK2lIQVF5bi9z?=
 =?utf-8?B?aFRXRHp0TExvZUg0ZDlGdzlmL1g2MVk5N2lwc0VsV3NlcVZweUFGdjdLNktG?=
 =?utf-8?B?dHZ0WUtIUzJOa2w5SDBNbDJydWNiOWFnKzFaZis4cE9jQndRNEhqT2taTUh6?=
 =?utf-8?B?SENaZkljK0EzT1hOU0p4UnlRMHpFVzFwR0pCUWdnYXpKZGNoMzJaSkNON0xX?=
 =?utf-8?B?OTh1WnZ6MmxTQllxdTRLc0tsSXluT0V6NmpZV3F1NXZ5UURXRW8wWWJtcHc5?=
 =?utf-8?B?amVWdjlpZ2RUcUVvT3RJRWJkSTJnWXcxR1lHbzdVSy9XakhFVlFvMy9XbklO?=
 =?utf-8?B?QVk2YVhDaGdwTW5paHNzL3Zlam53aEs3ZWFibkhmZ1hkeW9xdnVBdzhvM3FN?=
 =?utf-8?B?SVkzQlo0Tkd6Uys4TmxZRGhCMk9iaGkxRWFFekNwanUwWTBtOW1yelAyVzJr?=
 =?utf-8?B?WWdYUWRrOGpRK3l1clViM0ZERUVBb2dJYlVReTBLbW1SK0ZoT1MxWWJNRTJP?=
 =?utf-8?B?SXRDZHpvSE82TUkvRy9JR1plc1BjYkFUcVlnWHN5Nldzcmo1SVp3b25KRTQ2?=
 =?utf-8?B?bEpXNHg0NHcxNlp3Z3lkbjBLSGpHM3l3THBHUUIzSlhRdFhJMmhUeW9NRWR4?=
 =?utf-8?B?c09BV1BaeFFleGhRcm55WFNDZS9VV05Mb0hUZ3cwVUhTNVdXUEpnTW1lU1dP?=
 =?utf-8?B?UXgzRW1yYktja09XblhBRzdyZjhGdlZkVWVZS3JZK2o1Y0NnOStQMzRjYUwz?=
 =?utf-8?B?eWt3SmE5b2lsZ2ozNlJ4ZFMvd1A3cVFGQzF0VWVJYzlCRmVJempYaXJEanZK?=
 =?utf-8?B?SVJaWTh5ei91UXd6RkdmYUNKWEM2M1QreXQ3MUZxWEZhNWswSXlLaWhNYnZ3?=
 =?utf-8?B?ejZ6ZjQ2Y3hieFFSdDJNT1JGR1ViakJlU28zekFLK081U2FlbWppOThSOVJt?=
 =?utf-8?B?SFNXSW1EZHlPRlpEQ0FYUmpteU5kOFlDV0MzMkRFK3pIRnIzMGZwQlJUM1lk?=
 =?utf-8?B?TUNMS1U0bEtWMVE5d1VJbGZkNXNDZjV3Qm9WN04xRmpqaWxPaGJnQ1pvMnFR?=
 =?utf-8?B?RGRLRjI0WjhiSjJtMDFIOFh0RTFDbXpuSkF4a0lIZUFzM0J0aWtqUWNrbGxR?=
 =?utf-8?Q?KaKbFa/BtFcp+2IJtv0p/cuvqD2Jx9ceX4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6051eb13-d2ef-459c-d5fd-08dbc34ca712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 13:36:59.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udJuVbRWz0h3jjX8CYwjAlQq+OYO/yMiXWMHYkqWVJ7yE8dx4j+E4a/Pw4rE/6df8pYOydc/+Chrx9gB8K7ByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020102
X-Proofpoint-GUID: KZ47_TcIbtelGwuNASywgcfW167EXquV
X-Proofpoint-ORIG-GUID: KZ47_TcIbtelGwuNASywgcfW167EXquV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 29/09/2023 15:08, Eric Auger wrote:
> Hi Miguel,
> On 9/25/23 18:20, Miguel Luis wrote:
>> Some _EL1 registers got included in the _EL2 ranges, which are not
> if they aren't too many, you may list them as it eases the review

Thanks for bringing it up.

Initially I thought those _EL1 registers would be ESR_EL1, TFSR_EL1 and FAR_EL1,
but as I re-run through the process I cannot confirm the statement anymore.
So that statement is a mistake now?

I took as reference Table D18-2 on page D18-6307 where are listed instruction
encodings for non-debug system register accesses. Having to deal with the
document format is surely not an easy task, so I converted it to text using
pdftotext -layout.

After scraping, the end result is a table of encodings which we're allowed to
sort/grep which may be handy to this when you consider the statement that all
accesses (but the exceptions) to system registers ending in _EL2 should trap.

>> affected by NV. Remove them, fine grain the ranges to exclusively
>> include the _EL2 ones and fold SPSR/ELR _EL2 registers into the
>> existing range.
>>
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Fixes: d0fc0a2519a6 (" KVM: arm64: nv: Add trap forwarding for HCR_EL2") ?

OK.

>> ---
>>  arch/arm64/kvm/emulate-nested.c | 44 ++++++++++++++++++++++++++++-----
>>  1 file changed, 38 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
>> index 9ced1bf0c2b7..f6d0c87803f4 100644
>> --- a/arch/arm64/kvm/emulate-nested.c
>> +++ b/arch/arm64/kvm/emulate-nested.c
>> @@ -649,14 +649,46 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
>>  	SR_TRAP(SYS_APGAKEYHI_EL1,	CGT_HCR_APK),
>>  	/* All _EL2 registers */
>>  	SR_RANGE_TRAP(sys_reg(3, 4, 0, 0, 0),
>> -		      sys_reg(3, 4, 3, 15, 7), CGT_HCR_NV),
>> +		      sys_reg(3, 4, 4, 0, 1), CGT_HCR_NV),
>>  	/* Skip the SP_EL1 encoding... */
>> -	SR_TRAP(SYS_SPSR_EL2,		CGT_HCR_NV),
>> -	SR_TRAP(SYS_ELR_EL2,		CGT_HCR_NV),
>> -	SR_RANGE_TRAP(sys_reg(3, 4, 4, 1, 1),
>> -		      sys_reg(3, 4, 10, 15, 7), CGT_HCR_NV),
> I am not sure I fully understand the sysreg encoding but globally there
> are not so many _EL2 regs trapped with .NV. And I can see holes within
> somes ranges defined above (I searched all "if EL2Enabled() &&
> HCR_EL2.NV == '1' then" in the ARM ARM). Maybe I don't know how to use
> the ARM ARM doc but I feel  difficult to understand if the "holes"
> within the encoding of some ranges are unused or are allocated to some
> other sysregs, which wouldn't be trapped by /NV. I fear range encoding
> may be quite risky.

That's definitely fair and I share the same concerns too.
Having table D18-2 sorted helped defining those ranges although I did not
find the answer to those questions. Perhaps we could query for assumptions
on the desired approach in which such implementation would rely.

>> +	SR_RANGE_TRAP(sys_reg(3, 4, 4, 3, 0),
>> +		      sys_reg(3, 4, 10, 6, 7), CGT_HCR_NV),
>> +	/*
>> +	 * Note that the spec. describes a group of MEC registers
>> +	 * whose access should not trap, therefore skip the following:
>> +	 * MECID_A0_EL2, MECID_A1_EL2, MECID_P0_EL2,
>> +	 * MECID_P1_EL2, MECIDR_EL2, VMECID_A_EL2,
>> +	 * VMECID_P_EL2.
>> +	 */
>>  	SR_RANGE_TRAP(sys_reg(3, 4, 12, 0, 0),
>> -		      sys_reg(3, 4, 14, 15, 7), CGT_HCR_NV),
>> +		      sys_reg(3, 4, 12, 1, 1), CGT_HCR_NV),
>> +	/* ICH_AP0R<m>_EL2 */
>> +	SR_RANGE_TRAP(SYS_ICH_AP0R0_EL2,
>> +		      SYS_ICH_AP0R3_EL2, CGT_HCR_NV),
>> +	/* ICH_AP1R<m>_EL2 */
>> +	SR_RANGE_TRAP(SYS_ICH_AP1R0_EL2,
>> +		      SYS_ICH_AP1R3_EL2, CGT_HCR_NV),
>> +	SR_RANGE_TRAP(sys_reg(3, 4, 12, 9, 5),
>> +		      sys_reg(3, 4, 12, 11, 7), CGT_HCR_NV),
>> +	/* ICH_LR<m>_EL2 */
>> +	SR_RANGE_TRAP(SYS_ICH_LR0_EL2,
>> +		      SYS_ICH_LR7_EL2, CGT_HCR_NV),
>> +	SR_RANGE_TRAP(SYS_ICH_LR8_EL2,
>> +		      SYS_ICH_LR15_EL2, CGT_HCR_NV),
>> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 0, 1),
>> +		      sys_reg(3, 4, 13, 0, 7), CGT_HCR_NV),
>> +	/* AMEVCNTVOFF0<n>_EL2 */
>> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 8, 0),
>> +		      sys_reg(3, 4, 13, 8, 7), CGT_HCR_NV),
>> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 9, 0),
>> +		      sys_reg(3, 4, 13, 9, 7), CGT_HCR_NV),
> I think those 2 above ranges can be merged

Oh, indeed. For both AMEVCNTVOFF0<n>_EL2 and AMEVCNTVOFF1<n>_EL2.

>> +	/* AMEVCNTVOFF1<n>_EL2 */
>> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 10, 0),
>> +		      sys_reg(3, 4, 13, 10, 7), CGT_HCR_NV),
>> +	SR_RANGE_TRAP(sys_reg(3, 4, 13, 11, 0),
>> +		      sys_reg(3, 4, 13, 11, 7), CGT_HCR_NV),
> /* CNT*_EL2 */

OK.

>> +	SR_RANGE_TRAP(sys_reg(3, 4, 14, 0, 3),
>> +		      sys_reg(3, 4, 14, 5, 2), CGT_HCR_NV),
>>  	/* All _EL02, _EL12 registers */
>>  	SR_RANGE_TRAP(sys_reg(3, 5, 0, 0, 0),
>>  		      sys_reg(3, 5, 10, 15, 7), CGT_HCR_NV),
> not related to your patch but wrt the EL02 the only ones that I
> idenftied beeing trapped by NV using above search are
> 
> CNTP_TVAL_EL02	3	5	14	2	0
> CNTP_CTL_EL02	3	5	14	2	1
> CNTP_CVAL_EL02	3	5	14	2	2
> CNTV_TVAL_EL02	3	5	14	3	0
> CNTV_CTL_EL02	3	5	14	3	1
> CNTV_CVAL_EL02	3	5	14	3	2
> 

That matches my search too. FWIW, below are the _EL12 from my search:

AFSR0_EL12 	3 5 5 1 0
AFSR1_EL12 	3 5 5 1 1
AMAIR_EL12 	3 5 5 3 0
CONTEXTIDR_EL12 3 5 13 0 1
CPACR_EL12 	3 5 1 0 2
ESR_EL12 	3 5 5 2 0
FAR_EL12 	3 5 6 0 0
MAIR_EL12 	3 5 10 2 0
SCTLR2_EL12 	3 5 1 0 3
SCTLR_EL12 	3 5 1 0 0
SMCR_EL12 	3 5 1 2 6
TCR2_EL12 	3 5 2 0 3
TCR_EL12 	3 5 2 0 2
TFSR_EL12 	3 5 5 6 0
TTBR0_EL12 	3 5 2 0 0
TTBR1_EL12 	3 5 2 0 1
VBAR_EL12 	3 5 12 0 0
ZCR_EL12 	3 5 1 2 0
TRFCR_EL12 	3 5 1 2 1
PMSCR_EL12 	3 5 9 9 0
CNTKCTL_EL12 	3 5 14 1 0

Thanks

Miguel

> Thanks
> 
> Eric
> 
