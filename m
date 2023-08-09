Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3C7756CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjHIKE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHIKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:04:24 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747141BFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691575463;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jo5GvImISm0q2Hn/NtuqchtzzAwhFUYVNlGSJb2wLEE=;
  b=QkEOqbvNcfTD79KdEVx7/3nkLIepr93ehR/Rmz++5EngrJgngwn+XzjH
   QtdWP9DMKfVJZHzujWaD0ZyB9pMkT009DGaNjpGLV3jLNvy0xVOISMmX9
   oCwuRzZ2R5VB87eTJ7o3jbXEHKyko6vghkPLyOMFWgHI4bOLcIyTCGxh8
   E=;
X-IronPort-RemoteIP: 104.47.55.103
X-IronPort-MID: 118853582
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:s+q6kKptxBeutaCPf7LocasJz8FeBmLpZBIvgKrLsJaIsI4StFCzt
 garIBmGb6reMTD0fogiO4ni9ExS6MLdnIIyT1NoqS9kRCobpJuZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GpwUmAWP6gR5weOzyhNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAA0uQA6+3cbr/OOiSNJWg/4oF+/iLZxK7xmMzRmBZRonabbqZvySoPpnhnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3jeWraYKOEjCJbZw9ckKwj
 2TK5WnmRDodM8SS02Gt+XOwnO7f2yj8Xer+EZXhr6463QbOljZ75Bs+clqK4sjlzWSFf+lbE
 EhNpHF2/LEpzRn+JjX6d1jiyJKehTYEVsZdCf8S6QeD0KPY7g+VQG8eQVZpeIx4nMw7Xzon0
 hmOhdyBLThutqCFDHGQ7LGZqRusNiUPa2wPfykJSU0C+daLiK06kBPDCPVqCKq8iPX8HD22y
 DePxAA8n7ISiMQM2o248ErBjjbqoYLGJiY6/AjYXWKN6gJ/eZ6rYJGu5VHH7PFGaoGDQTG8U
 GMsnsGf6KULEsuLnSnUGOEVRujxvLCCLSHWhkNpE9857TOx9nW/fIdWpjZjOENuNcVCcjjsC
 KPOhT5sCFZoFCPCRcdKj0iZUqzGEYCI+QzZa83p
IronPort-HdrOrdr: A9a23:kfL1l6AeXi7d/MvlHemo55DYdb4zR+YMi2TDtnoBLyC9F/bzqy
 nApoV96faKslcssR0b6LW90dC7LU80lqQa3WByB9iftWDd0QPEEGgF1/qA/9SJIUbDH4VmpM
 VdmsZFebnN5ZQTt6bH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3A4wHcCWlM5/QHdUK1uNDnuLM0PPTXOUD+4mnteWv?=
 =?us-ascii?q?lNTdwSoavTGWbw4VtgtU7zg=3D=3D?=
X-Talos-MUID: 9a23:OJmoFgmZh495Zb1+OYxrdnpFNfYr0vjpInspqpE9v5DabnQhIiyk2WE=
X-IronPort-AV: E=Sophos;i="6.01,159,1684814400"; 
   d="scan'208";a="118853582"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2023 06:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSo5jdvutNZYfGWyE07NjqitL6U8+w7jPZmIPIes7/+PwGPCXIVr0YmPjsVridxEAQyYp8ow0SqpaVSob1sTkLsV581LipPSNNvDQ97mOZqX5dHnxJf1ZDDQOsykm2fR0JWDeKJr2ZGsv0DmQCs95GAF/g8tyN3lvAG4cyrirtmirWbr7j5XWkb6ZtnFlB+FcxzSUy6eFXaatRePZks+x3n1+yEWQROLaSR2/OaPcuyMh+xKIGjJmg8g5Qr0AT+tbO+YivoQ216pwwJgUSp6koQl9sYG+ozh3SXn2fD4rvPvr8U1yLOgM4GwcDPeh3AoZkBqD0tSwRs6L5zApse04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg2BU5rlQd+tTCnYk87Xx/yE+Bdcj2M8YcJLVNS02eU=;
 b=Uyop0RYwxRcMGn0W3k2n4ERuHW/dla9v/d5wViSc3aucehp6b1QwUbn/kDgZla3lP1JS3f73VJmgKcvJ//QbW+sar7VFuTPd1A5nbFJumPfhUstaZoMuaLbF+VhsBAEzFKlnNYwtWQksujREf0ogQBRi3k8XZizLL6KhzkgRCkU1Y/CqdTGHn4qKPOTJ0uYdQYEyuDxps5HnJoiq+FH2l0FgfWXtCHi9OtIzWMI21ATP/HpKNvqzmrhcK/+bQFk5iYFUqRN97FDzCY/Xx3BJWvnbXI6Ax/uN1MorFv1fX7pRFZhqw4IsGTYIbKzjnyrb1DsqRLdx21Bp07rZZcaBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg2BU5rlQd+tTCnYk87Xx/yE+Bdcj2M8YcJLVNS02eU=;
 b=DoKzKoCibgXgbFY8Nbs2mGCDEK4wPedIir5UoKH00oC818+kOYrhxxWkHbeiiz8KIdF+TLRYB+nxpu3hU49mrWK53Il5E8IVbwI7gFfCN1N8Fhlv2Xho2tvZGAfwkmnXsh18Asa/Yv0VshTzQpKh9E7q8+cPyMBh0sU23K1mLtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB5847.namprd03.prod.outlook.com (2603:10b6:510:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 10:04:20 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 10:04:20 +0000
Message-ID: <341a47de-2c12-43a3-2d5d-d9727a1e7420@citrix.com>
Date:   Wed, 9 Aug 2023 11:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew.Cooper3@citrix.com
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
In-Reply-To: <20230809071218.000335006@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::16) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|PH0PR03MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f03bf2-dbc2-44a4-bfcb-08db98bfffa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzLOzbF80mrTsAvFZfeMiLmXYfIT9JR0kwZt0mUmEN5UYDcoeqKqqIBUSYKz5pFO4Ax6eolHEjZdgqJBkag8y7M46Jsq7/rtZjm4kHqk4PhF4MH+/WUHdwde/mXUtIWRXNa21/EdxrUfUPc4W3UUsVN2KaIz/OcB6SFCgBmlbdonp8fY9s3kZlcxVU/btCf5Lc8tVr2xwnuOtaV5NMFmsuRfXQbrKZW+F1mdJdCgmUKWLCRijQzyMd9+iTBVMOwGW8nAO/uFr2fvslnp+aJfjKJhRddVonDT1jP/20HO3mmmm9nmFGPdrs6S1HmdcI5TlLepEH55DteuzmIeEKS1zBPRalIa5aX8Zf3V8+rlng+W8jS11+KeRRxNv7f3tIlred/32fr7Dum19vJBGJPndtiaLmxqzS7J5bH6L3QsPjibJUMQBh4Rch9n/AAG9ISbe3gy095HyRg1K0m6N0eORGFG9f7Kjiob0lDSz75zSJJowpPhEdDWVije+Po5lgn+BfHHTbtR5QBe6ZcN5hLtSPLQ1nP5yGW2xkKc9tzQXGSepxrOmx0Vn35FcCW2e1GwG12+Q8puFrqd+agf9ZXdf6tiZxnSv9ng7LGhSsQuIObG52B4uKs6R30E/PYaalEw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(1800799006)(451199021)(186006)(6486002)(6506007)(31696002)(86362001)(26005)(53546011)(82960400001)(66574015)(2616005)(38100700002)(6666004)(2906002)(6512007)(478600001)(9686003)(5660300002)(66556008)(66946007)(66476007)(41300700001)(8676002)(8936002)(4326008)(316002)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVkM243Yy9oa3ZoV2ZhMzBXRFM2QXM0MFNrdjh4WFREVUJ1K0d4NzN2L2VP?=
 =?utf-8?B?dXZXNVBjaVNVUEpKemlRaE0wc2tnSnNxOXY0ZENCbm9zb01JeENRLzZ3ZmhE?=
 =?utf-8?B?NnUzeGdpT24vUkhsdFlTeThXeGtVY2VzTlM3VnpyVTN5YUorY1oxOWJvc2RL?=
 =?utf-8?B?ZEl1UUh5L1krOHJUQzNXS0kwYWpKVXl6VGNuSjltVDJWYW5VZUJ1eG9NRm5J?=
 =?utf-8?B?NXZNbW9ycTNEYjI0eU0rVlUrMDh0SEtaNFp0aU5nM3I0NUprQVpmQXI4UEdX?=
 =?utf-8?B?Zy91SWpFaFdKYnE0N2NPNEp5TXlKVlRHWFVweUwxQzBtVWJ6RE9pcFVMTVFl?=
 =?utf-8?B?SXFaVjZ0UUovcW5BTFlNTW8wc2F5MXZGbWVseHhqWHpHd285RzUrTkR2emV0?=
 =?utf-8?B?UkVFYWo3RmVSRnVhMXIwdmRhWnZQMDJQQTVnZEs2MWJkR01XeWZMUjRHWUI2?=
 =?utf-8?B?SVdXRHVDd3YrdFl6YWVjN2lnLzhEV0RBUUJ6TnZYNDNTSVlIKzVkVC9zRnRn?=
 =?utf-8?B?dWI2SUc4ZE5HY2p0aUxnUGFZSHJrRlQ1MzI0TEQwMFZ4RHJ0MDZ0OHlKRG5o?=
 =?utf-8?B?bmVxOWpuZmJPd0ZiNFpnVUw4bnVRMEdKeUhnVlBPaElVb3ByVXExcG4zZWJx?=
 =?utf-8?B?d2dXNVNsUHVLRjQwUzZMdVFSdE9mV2hYdVhva0RJVnNKVk41dkZDMHMvK0lr?=
 =?utf-8?B?OFg5dk5leWRNdGxsa0ZsS1RMV2ZZc2Z2K2w1bWRHVW9XaXR3dHo0bVcwL3g3?=
 =?utf-8?B?a3pNMkkvRjA2QS9sOGtOZDl0dlV0SjBEYXBpaTJoNkRBYkNxcHdmQmZlZHNF?=
 =?utf-8?B?WE9ja1c3bDhxd0tFUUlaSjB0N1ljNkZHclYwVG1DRWwyRlM1Yk1adXQ1RVZJ?=
 =?utf-8?B?WFpsMG5kQVFWdG1nTW11eUI0TW8rZ2dIVFBSSkpuZ0ZBSDNPcEwvQVl2ZXZq?=
 =?utf-8?B?K0ZUNEl4M2RjaTNCcm13QjY3NFJkaFY3cU5MRWFTVHFZcWpPL3N1Ty9MNXlm?=
 =?utf-8?B?RDIxOU5sNG9vWXpuUElTZGdIL1N6c1FicldzOVZOazR5cCsxM1lWTGNyV3NW?=
 =?utf-8?B?MHNXZkFwd09hbExFS1VsdWF3TEx5ckluWXVGUTRRb1R3VHgvQWhoaG5UK1hk?=
 =?utf-8?B?UnFPUnNPVEdlcFNtbWxpT1B2SkkzZm15ZGwwMklDVXljWUZRem45QllFU3V6?=
 =?utf-8?B?SVRaM3pIaHFLNHprR3AxVWx2eG9BcjNVWngyT3dSUENCR00xZFZOMVo0OW4z?=
 =?utf-8?B?UncxNlVtaEhTbkg4dVpvNmdjYjg0eHUzUmdGblBycVpNTUtrNWhURnI4VGl1?=
 =?utf-8?B?R0xQVjFoK3ljcjZTQ1pvR1ZJL3NGclBNQWU1aVFUclJGUi9sOVlOMmdCcy9p?=
 =?utf-8?B?RDQ5NzNhWSt1VFlmTlRXZXpaV3F0N29aOHVBQjlRTkY2cGd1NjdtZTZmTnh3?=
 =?utf-8?B?WmtubWFpTWpzYXlVWGZ2dU5UWDdWRTZBWEhhL3RqbnV2VTdqb2RJNS9DUVhB?=
 =?utf-8?B?UGJ2VTZJSWFxTno1UDRkZm43VStYbDBQTVRlUnc1R044MmF2cXdvWDhFcThN?=
 =?utf-8?B?N21BcEVaZmdTU2VRTGlOcC9xT29lektLZFpvQ3FCNy9KSWFvczNXYkhGMkNs?=
 =?utf-8?B?dERnWFY0YTlQOVROZ1ViNlRjeGp5WnpQU1NobXNxcUNVRFNaRHVOVEZxeko5?=
 =?utf-8?B?NjQwU3k0dkphckxwYTh3aDZ4eFBFaXpkajhFWmR3aUVFUTNuMVY5N3Zabm5o?=
 =?utf-8?B?cWtYR1RIQVNxeTlOaGdETzA0ajErQm9WYnJNV2lLMlhUM2QvZlZYMzFwZW9Y?=
 =?utf-8?B?c3RlUkFFNFRZc3RucERidGFDdTZHcTJSTnp2cElLZXRBV3EvRjRYMXpXb010?=
 =?utf-8?B?RDZzai9WOGRYalpiMkcwNjN2dEJVMFV0Y05QWXBpZGoxRzREUDhiTHJhYWFy?=
 =?utf-8?B?cGRneXBDMU9wMUlMS0R1dWFWS2FmSEdIaE1LeEtwK0VTUVg1T1oxZnFkRXFx?=
 =?utf-8?B?c29MV1lxSXpDQlpEbmFuQTFOcUxGQTA1R1BNRUlTdmxPaWRsaDVkK2hrU0li?=
 =?utf-8?B?RlgyNmhuL3lCNVVwNkNXQkVKRmNlVnhrU0hEcCt0MTZreFFaM2h2aUtKajR6?=
 =?utf-8?B?V0FFdEpNMndUS3RYUFVWSkYwMXhzTjYzbmYyZjFxdXdFRC82VVBMRVIrVXV2?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uGeLridopffpL8z9ANr+w1HgqIxe/uInlrj5Q9vecKtN0SZDmq60UJJ1NFF0E+jcLNfXDTgox2+hVwwqwbyumXo+lxtmevxo8rP0DgaHW/GAJ7WEi7CcaTBHBHcDUjxV0ZQD5YWu0+mWzGpo8sIMkDvvJDdefmqN3OnyLdmlIdeXZSfQfiXLekDB/KyFhx4XOh4N38zwXmupW1M0JrKiaf1rppXdGIZ+2CnZU4AtxvSgz8S3K18R2ukpy4ZrWAuHwyqMvtYTU2++yk/UPOZ33WLFQ3tWR+KZGLN3GpeVHJSPA6s7MLCxTovuDUbGTr714W9cSVJl89W3tngdGKSOQuEeA2mnJkHeVly3b3ilOINZEa8tdDRYr0pYqw0fdfughFDBFI1ITUhODHyhPuDPn2Wq1X4ZQllfcS3qDYTvnWmDLs9u+6Z6T3PCDLS8OXx36nSovPNjtnpJXBvuYMNGEjLGinVYHQ2O+uC269rciZqC/xPK35yzNUVAMOuU9kQk5VJnT+O1OpfUwHvOBuWlgNS6nNcPQs3IKjGCV4cxcUwViWY0e6dNpNdyPHqNPBCf1PZOpE0OUAl9bhm55DKR/YGImEOxFya0gTBFQGMs2+KPkpI1bg4umA1kE3ZNAUwPamhVmIrQPHoXD4J6FMAWj8RizoVci0wFOimCUlTqfLqC5NgK1GshMYFhKWtyixz4IOn37POeukk/zi8a/gxepJSZnn9tqKsiSJBXNjQ4TBAMTTZ+mOupVlKBtw+g15gRbm/jk3V2tKzlljH8uM2py+r55Y7p5HPIgE1KgX5TrcJIywIfHvthxp8FZGnI8VhjoNM4rh+cOTapIqAu9X8BvS20VMHdGfU3Qf+ogJeidyTaY6f+JINNQGvUOnSYyYSllsPwJNXeYLDIKwOUFs3GrA==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f03bf2-dbc2-44a4-bfcb-08db98bfffa6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 10:04:20.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU4+QfMbhBdeJ1YJ4RAYjyHCZBvD/BoLQhiwnrjID1y4K+S/DVxXG4wtvQ7vGG0V4v018pRQ9Ghew44ZGxUnWJqSisNH3nweKAvAosc152k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5847
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 8:12 am, Peter Zijlstra wrote:
> Since I wasn't invited to the party (even though I did retbleed), I get to
> clean things up afterwards :/
>
> Anyway, this here overhauls the SRSO patches in a big way.
>
> I claim that AMD retbleed (also called Speculative-Type-Confusion

Branch Type Confusion.

Speculative Type Confusion is something else; generally Spectre v1 or v2
around a logical type check, usually ending up confusing pointers and
integer.

It appears that you might be suffering from Type-of-Speculative-Bug
Confusion, an affliction brought on by the chronic lack of documentation
and consistency, the fact that almost everything has at least 2 names,
and that 6 years in this horror show it's not showing any sign of
slowing down.

>  -- not to be
> confused with Intel retbleed, which is an entirely different bug) is
> fundamentally the same as this SRSO -- which is also caused by STC. And the
> mitigations are so similar they should all be controlled from a single spot and
> not conflated like they are now.

BTC and SRSO are certainly related, but they're not the same.

With BTC, an attacker poisons a branch type prediction to say "that
thing (which isn't actually a ret) is a ret".

With SRSO, an attacker leaves a poisoned infinite-call-loop prediction. 
Later, a real function (that is architecturally correct execution and
will retire) trips over the predicted infinite loop, which overflows the
RSB/RAS/RAP replacing the correct prediction on the top with the
attackers choice of value.

So while branch type confusion is used to poison the top-of-RSB value,
the ret that actually goes wrong needs a correct type=ret prediction for
the SRSO attack to succeed.


Both issues can be mitigated with IBPB-on-entry (given up-to-date
microcode in some cases).

Both issues have a software sequence that tries to make the contents of
a __x86_return_thunk sequence safe to use.  For BTC, it's simply a case
of ensuring the type prediction of the one ret is good.  For SRSO, it's
something more complicated and I don't know the uarch details fully.

~Andrew
