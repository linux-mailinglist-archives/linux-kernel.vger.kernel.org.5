Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C567E0A49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378327AbjKCUYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378318AbjKCUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:24:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0381B8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699043052; x=1730579052;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/VBWQ0gm4148MhUOV9U48OQmyMnluREg+9POuk3NxqM=;
  b=L+SuXRv1mcFTLigcdrehLAfhFmpAhVN/6Azz2QBCWQuyuPeXXkOVGAHu
   MYh5ipTs2kftOduYRg4mDaplnRX8+kv2RjkRpFRyJYgojW85YjcvWmCkK
   TVyXmilg79PZy8R2CuQdWYUSbuhzEfs5wxLqZ/NLgp8zOSP9Sdl6UKUzT
   shVqtU74NWv/WBFrJuUdkt4T0+ziBy6aDvUT0b6nx7aSyWHw9MMzOiaYT
   zhvtaLlBzhjDveQ1vhKxHmSQso64wBu2wGpN7cBR4mDSkBL6jO95H6MEu
   8u2APZ4gwoAB6MglxHMwU+tTd27dcaz0Oo6rUs2bYogxmdeRf+UiveJLZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="455504945"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="455504945"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="878759762"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="878759762"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 13:24:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 13:24:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 13:24:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 13:24:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 13:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxteinhCQo9dOLbeq36D4izJrFNJi0ixXAx6Y9UFv5287uZoFW3Jt3v3PVZas51+jPu50SKx6FdNf0yuP6+UQ1cryPZcufbNBbFvHZtGjDiCqdHqAHTAc2DI0hjMFS720WxIibjXb2BXsqpFTQGNXaL5ukclkt/ZC4D/fbOwb7/20RGzSvPgtoyLBy6BPv+PhAHPI8nO4igEuO2LMJkyVKu/FYDftrkCA+vAp7WkSG9lycg/WNaEP2sZxxzpmIYj5r81IgrNZyBA5DyiybLCFkQSG0CVNs5JS4LdE+DG/jbOeyKpwJoYxx0hzWLQQ0UrIL9WxuFrnro4NMX/3pURtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUbeXLexO9ef6EnDHKTY6TMXG+fWNBmd1G4yiaO8ok0=;
 b=X4lRpOji7v/6J3y4mEY8dt66Yh/r2D+ggRUlclkvPK+wA2ce397/rBTqJ+Q0scZtY4R2b4pY72FJDW45T2RUlrPsY3O2HQYoSN5+fqn8Df+jPOQC78oPY+7cmuE+MX+z67kMjp87v5V8lC70Lw4Dz3UNgrcBo5+NBAC+gkBt6Scl+58pDqMr2JmCmBfhYljTfRQjOP5fbmtukYX8CNCblne1wUrkxispZLYjyXziwIUbFrNmAIzml7BRRFNxRji99+0Ob0JNDTTsk4Hq/XyLKM+aS/AoBUaber7+qEtagj/iWS1GnfTsgp805xk1eDTNm9Mn1KwPHhxGVZ69u4LXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6856.namprd11.prod.outlook.com (2603:10b6:510:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 20:24:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 20:24:01 +0000
Message-ID: <d0a6ca2d-250a-47e2-8dda-b4e7d74a7ffb@intel.com>
Date:   Fri, 3 Nov 2023 13:23:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Moger, Babu" <babu.moger@amd.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
 <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <9e6a979a-48db-4b25-884f-ac8d4c2bb078@amd.com>
 <ZULCd/TGJL9Dmncf@agluck-desk3>
 <3ca2b0ed-6732-4fc4-a5fe-1846b873b02c@intel.com>
 <SJ1PR11MB6083D8F1467F094A5F1993EAFCA6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0f8bd2b0-025b-424e-823e-03e51e99cfcd@intel.com>
 <SJ1PR11MB6083E6ABE4D467D5D275A309FCA6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083E6ABE4D467D5D275A309FCA6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0373.namprd04.prod.outlook.com
 (2603:10b6:303:81::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: de779162-7696-4235-1ac7-08dbdcaad12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ar9531hqLMzmDyy7wWBUEKJq0NCCcmmnT0ITceUW2OwpnXyPtJ2LzwMglxsmNYW10YAhTW5ppgEuZwWNvnzlkSb9CBWVtFCj0SoIrdpkJEzPkgXyZmbTR7AAU+WwtgxTVmUEb8A739vXXxbOiGkZGL6q63F86AL9L0y1LLvxlXknRfKrTG3HuDztTZD9im/RhjMJiMA6XWI6FxP/EzCyNJAz2FsZw2V7JyKpAGRraBPe2ylZTcps/XJFbyQ5OuABI0L9GvaFObuKOtgYs3WSW+JNiAfFsYWhI0UxFPYWF0AigDNWe7RxacCX7VaYuP1gMQQaLxAv0ND8qVVuX2kuDXGLWpRh7DILeuIfwzT/eJhxtKf0c9xrEv+ms5GguqBmAIVlr98i2J1xciN1SAsEZxvWqRcUYcR+OLSJ8soU+7jQx1zu8OQViNP9DfQLA39spe9bRlYZ/heAmEgMzgBm2Dos+vfMAmRXlD1/SK+pgePSiErPTMaLRZ8ojCdPqLsP+/uDUP9fhiy+BiU7T0vDX9tY5k9FrXl/YQ254QOacy5jH/mfZ74x2nXaf3C+K2h+Sr6KGatZQqA10wX4yX/TQr96TI9Fg2L6Z9RA60vmsUX0D2yEqFtSDcsOYyjUozcVVy0fyawrvADJzjE2eudoE1ifX9LKlw3u9a2Y6ndCKHUPORkejnQijsacMvqU9yDl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230273577357003)(230922051799003)(230173577357003)(1800799009)(451199024)(186009)(64100799003)(2616005)(6512007)(41300700001)(44832011)(36756003)(26005)(83380400001)(8936002)(66946007)(316002)(66476007)(54906003)(66556008)(4326008)(8676002)(110136005)(53546011)(6666004)(6506007)(6486002)(478600001)(4744005)(82960400001)(31686004)(31696002)(2906002)(86362001)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZhL09PdWJUOFNQT3RVelVpazFZQTdYMUhoU1pWbjdlUmExOU1qNXhzK0s2?=
 =?utf-8?B?TXFYWERCc0dkMlVic3FhamVYblY2QzdSeXlKbytaaGNicGx2TUo0dzdjckZ0?=
 =?utf-8?B?ZkhWOU9tRVZ0WVFZLzBESG9kcFV2dWtiUUJyNHNzSlhidGdnNGJHdVNscGdn?=
 =?utf-8?B?czVzdlFGbnJ3UE9EWE9EOVg1UjVZTkM4OTU3d0t1YklRblJDbXpuZzZqMEdx?=
 =?utf-8?B?MWJrSVMzbFkxYjMvdkh6YUYveTd6UmYwWEhxcHNMOGpQUGswYXY1OVRnTTVv?=
 =?utf-8?B?SXJ5VFZrQkIrL2F3SXZ3NVZ6SEZDbzkwZktHdXAwek9TUjdodDVmdmlUS1lN?=
 =?utf-8?B?N1Q4eFFzaGhTS1ppYVU2VzEzYXAwZC9ld3FFbjh4Wm9WNEhhdWJiamcyNEZz?=
 =?utf-8?B?bGQ1OHVXampFbW14UXNHYXhBaThJRGM2RHlWRzVHcytxOWZ0Qmp4dmUvMTlr?=
 =?utf-8?B?OGhoR1N6NDR5aFRzVENhTnRCK3k4c0tLZmtCQTdOQTJWN21manNIWHlHc2xE?=
 =?utf-8?B?RTUzZjNTTUVRRTAvOFovU0NoTGVwL3FtRWQwbzIyOGJnblNBbEJxbFVpcFp4?=
 =?utf-8?B?NExTandPYmx5enBNaFRydlhCZkxmQTRCQUc2aXFSdE12T3llOVdhVFdnU0Zo?=
 =?utf-8?B?TUV3VHlmek8rTzc5U05WcWhYd2x1aUVEcEVySyt0NUYwNjlXWnhnakxrRHNo?=
 =?utf-8?B?Z1RZWHo5endObkNHV1ZuSHkzdWYvUDFybTZtbWNZMGhONExEWlRGMlNlS0Rn?=
 =?utf-8?B?SkV6Tm1zNDFkdlc4eG8wQ0R6Z2xNU2JLb2hWbVJ5b1pzaG1wb0xtSkE2dWEv?=
 =?utf-8?B?TnRZVTFhdkpzSkVaMzhDa0gwcy9sU01oTTgvYVVBZDBXeHdQM1JqY0c2bSt6?=
 =?utf-8?B?N3dCMHZPV0JqRnF0bjU4SGpScWs5M3dNbmdEK1hnaXFFZFpMVW1hM2k1U3c1?=
 =?utf-8?B?cTIxUENSNTBMRGdNUjlhcWtULzZ5MG9GM2F6QjA2UE5QQ0svVWlicXpNeENL?=
 =?utf-8?B?WlRvVjRLZFlaSERyVkM1MkZkYmZPcFJPOWM2bk54SkZnNHB3SktHRGRhTTlC?=
 =?utf-8?B?aWd6WnREOVpoUnVIWTVCdkRpMWtKdVZmSzZnM2J6eGZoayt6bDFEbDh1Wlll?=
 =?utf-8?B?RzNxT3JzNUFwZ1lHT1BzUkRqVlI1SVRYRTdiYVRNaTZFY29PenVNYUJxSUN6?=
 =?utf-8?B?TDVMemtsN1J6eUVUWUZsU1cwZEtBZ0tOZ1Jkc2Q5WUF2Qmo2T291TlBDK3dC?=
 =?utf-8?B?SzFiRlU3M25LNjQzZTh2NHBwZzhYaFFSaHNPbGhjZUs5R1RPVng0MlJjQ0pn?=
 =?utf-8?B?TjlZeUdYdFVORHBQRzc4UzlNd2ZxSEZsTW0zSCt6YUlUOFoyaUNLM1ZxcUx0?=
 =?utf-8?B?MER3VGVnRUhOaTAxdEVDWkxFSEZhTjdSL1V5UExuVzQwMFBha0ZPazNoZ1ZY?=
 =?utf-8?B?VUIwNDF2NXNQR1QrR2pHSklLZXhNNy9GZFNvcHNacmpyR1JLeXJibXRqVDJM?=
 =?utf-8?B?T3AxRXREMFdURk41RmhGV1NERnczcDEyQStnMXRNVEE3OGFQMVlXRC9GSWxJ?=
 =?utf-8?B?Yk9ZamxnU3JYa3ZvNW0yOVVOdE12emwwaHROejgyb1BkRUc2RWREY1lsZ0hB?=
 =?utf-8?B?cHZwcHo0UzRpcTREVUhHVE9nN093bk9WS2JtSG1QQmhpRS9aaDRjdzdNZ2V2?=
 =?utf-8?B?WGlqS3pFN2gxZ3ZlOEJyN3RoVUJ6TERQQU9WQm1YYjk1K3pkcS81WVI4TUhD?=
 =?utf-8?B?T0dOZ2pqYUtrR2Y2TUh3TE91QTVJaGxIMFZkdFJsdnVGMjZhcEFOZEFwLzBC?=
 =?utf-8?B?cGhETHFGMFVWKzZnUDlSdTJXRmtYMlBmdW52cy9zL1o2bU5RN0MwaWVYOHJK?=
 =?utf-8?B?a1NCZE1KYkRtNlM1dHc5TXAzTXlhMC9HTlJ4WjdJaG1UdTlYcmI4MVo0UUla?=
 =?utf-8?B?b202b0k4d2Y4ZEVjYmRxWHBYazk4RHFLNlZWOWhLdlhieGNMWk9jdnVNUU9a?=
 =?utf-8?B?dW5XTURaeTVBakF4RmM4dENaZHgwaW5GTVRGb1F1aFBPeldlWUFJNW1NMTBN?=
 =?utf-8?B?RmNEb1ZWQzRaVnVkblRldGdERnllS1d3SFhaQTN5Y1JTbDdianZaSEFWZWpk?=
 =?utf-8?B?UzVHNmhnOUgvWUdXMUw3M0hPYU5Xc3dtQjlDamNRYm9TU0FIQlhXRE1HeWlJ?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de779162-7696-4235-1ac7-08dbdcaad12b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 20:24:01.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Zgm0/AcA1trYRiMIKrCX/tVg4fa/GPuKWM1SAO5QE/chNBA7ymtFUxbL2ZJiSvAXRUwbg9r4jZCAbLGGt7EROEOIxnv4cSrrB5D3rshT/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6856
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2023 3:50 PM, Luck, Tony wrote:
>> This does seem a valid issue and my Ack remains. I'm just puzzled why I do not
>> encounter the same warning.
> 
> Reinette,
> 
> Some other CONFIG option changing CFLAGS?
> 
> Here's what I have for a "make V=1 W=1" for core.o
> 

Tony and I went a bit more back-and-forth on this one and it appears that the
relevant code is optimized out in my build while the same did not happen
for him. 

I can now trigger the warning by enabling Xen support, with CONFIG_PARAVIRT_XXL
causing rdmsr() to be replaced by paravirt_read_msr(). With the relevant code
no longer optimized out, the warning is triggered.

Thanks Tony!

Reinette


