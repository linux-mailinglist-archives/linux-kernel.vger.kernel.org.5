Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69427AF69A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjIZXN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjIZXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:11:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9157EC5;
        Tue, 26 Sep 2023 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695766399; x=1727302399;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KunAW4PB+hR9krnnArW+WE99CHIeQUHdJr808AtAQkI=;
  b=AoZAu96v8tgcV+fK4iug/lNH0Q7AH2WuM7F18Ebig5DH+02rfAM1cM0Y
   PghiHAmanfaAHV9cz5a5ds4lQUBCpT8Z18oiz9AUnwjIdWrDX2rXy4iZh
   kDczKO5cXPaUPT0e6Vw7Za3H5dlPlG15+j5P0PwgtMx62DQG9L9ND89ID
   KsyrZGTGZGbOPriV01l/HHrOtk2qKCIEwLoc8miKEf08MTCWmqafRl4PM
   flUTi8KOJR0gC+RgCn1OEu8yLAuL7yurCmanhv8LcZRf6N1iQGyFcdQ3L
   2YFETS5eMJ8fDKNr6gFG4wmN9CBSY2vaUZYDbrT+lr7Fm/KOYwUIdO1TU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="467961284"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="467961284"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="995930701"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="995930701"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:42:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:42:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:42:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK833SDBwt/tj0yjz0BJQBY7ztaO0NELxigBw8Z0y1xC3Ir7T9JAViFgbQFNLr24Xngq947dDZPHfiPV77cdjhUW5SVfuadAHD//Jnf1CrNbnvowAM4WpG79Cv0odPpta3PbB+fx5AsqhSVX5du0BmRAUmtK+ykJrTKhbUaNedw9ufbp+bKzbYxgjTS0K0iZ8vr5x1mZuGED0HK4QwginRBewSolaL09YfoosmrsIqFUJ0vNUmImsFzvAhUJXDUFRK96iYNen1hoS0acdrZ+LTiv5lf6v7Ak9Oh+0MsSRv7d7kvuMqhV7exk80WJ9oUx5Y+wnH3IuP9X5MTd+4kP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnIVpsaLRZV4rSTn0OmQtmRHznXHTc99jSp6Hraog0U=;
 b=AGmEYYvY6FaFHXEuJ3atq029fdQeMYcSAWkOhc05DHOkYlgsIqE5WtaSmeNZDR0pXn3UTeWyLiQ49GcXdbqow88H44+iath3+TKai17BXX1BbECT7ryCKYUyZ4zDJPuyu1HAV+pwv4O1+sHS/yVorjRSrHq/CiH++0Zkz7JVy7Gi3z6OZXdEB3uta7ihD/Wl4X2+58yA2jkqjQErwd7OAY83tJbkRumat9cSmlAOm6GMt5jcfjrLYvTLOMuJjYFuA1PFgFu1MjrZpbQPNwNj2t+J+tfLMGwBk9JMMKCzMG6HbylgKZcBX5kEZxU9iNwJYfTy/OOiXIOfeovwYSSe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5004.namprd11.prod.outlook.com (2603:10b6:806:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 21:42:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Tue, 26 Sep 2023
 21:42:13 +0000
Message-ID: <5ee77d8e-c5f1-cf53-268c-dc74fd3e37b6@intel.com>
Date:   Tue, 26 Sep 2023 14:42:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2] net: ixp4xx_eth: Support changing the MTU
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Krzysztof Halasa <khalasa@piap.pl>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20230925-ixp4xx-eth-mtu-v2-1-393caab75cb0@linaro.org>
 <b109470b-99d1-441d-0648-7b8e4a8c86fd@intel.com>
 <CACRpkdbcMCXg8H8SsuhPSvvtdqD1reNxpCiFv5eD=gPYKUyr9A@mail.gmail.com>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CACRpkdbcMCXg8H8SsuhPSvvtdqD1reNxpCiFv5eD=gPYKUyr9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: c505110f-c5df-4e13-2d8d-08dbbed971df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9s2P+i2VCOM0xKfMF6l+GmiqO0GUGItfSNDyu64pC1Lwky/nmEnFAMjDf0IfoujkoW46kWaEwN6Mwon+3/0gdLdhCjlJpbONnNL6jBTYgqVykwTZOceeshyaDSKKW/XaQ8po9AyuBmkdo9fmVKBarkspiX9WGhULo1yHDzzvZQjJyc3CySQvt7jPp//5qDd/HmYPV5eO9I5eQx5D6Q62SBSeU63TqGjftsrRWfBm+FiYkYvENZLYgih8NKlifXS/iFp3zL6A+oeox5zJlJK2u/kdZNxYQeMe/5Hq9plWwCgapwaWj8oA2otQJFE3csYE5dFt7yAZVBAjFRBWSfAw3vICkd0ei02M4zd4CnJoDZW6fnhZ2pO7g4WldqGhEUIXbj/cgLYgMHi5QNtYkMAUuLUaKavWIO1Bjw9IcDDOKfzG0J7G16OJRjY+uoD58KzDS4KsO7U8x9//YqrjmCDw5ht9/4G/qzRLHN3mEd6rAmmSgBHURnn/zaU82IC5PXlmbTjDBDh3otzyTTg2vzNYkcEROrf4YAlluUjsfp7BgYJKMn4N3la1SRph6kZ9Rx7ToY9YxGbXFRdg8injpGcKvRxnWMUhNfxQTjOXS1dnjRkZo+QwlOHhuN1G2mfCy6s42rnQ+s/ImpMn7YhqEQ15A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(107886003)(966005)(2616005)(38100700002)(26005)(6512007)(6506007)(82960400001)(6486002)(53546011)(5660300002)(8936002)(8676002)(4326008)(66946007)(36756003)(66476007)(6916009)(66556008)(41300700001)(31696002)(54906003)(316002)(86362001)(478600001)(2906002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0l6ZUFibnpIV1BpOXN1bzA0dlVQa211RUxNU1lHSERKQVRETkRWUzRTbWVI?=
 =?utf-8?B?Nk93VFZ2dG1xbTdUZEZiTkhBQ2w2dmZORnpjaEtPK3ZRVjZHR3dwVDE0a3Mv?=
 =?utf-8?B?ZHZQZ2lIQWY0a3kwbm5tK2dINTlMUy9yYnJKWHY3WnJ2Y2wwRm9UQzRYaEVi?=
 =?utf-8?B?eVY0Y0NGN0kvYnZpdVd0MFhEQ0Jxc3RLc2VtWVFqS3hHanE0ZlkrZnI3dHE2?=
 =?utf-8?B?eE5YaVNlR1E0dUdObzdFY0V3RWpWZ2gyZGMxVXJIdVZsNk5xbHh2VGNEbyt2?=
 =?utf-8?B?Sk8xTjVvMVdZMmk4VnMxZEJtZ2tkZHlGSlprZU9pZGNUWlBtSU9Bb2pYbjlt?=
 =?utf-8?B?WUhwRE55U3l6UWpBWGMrNzhCdFV6aHNseWJQNWkwRnlHVm1SNEFib1Z6bXd6?=
 =?utf-8?B?akY4dXplbUx0UTI0WXkwcWtCUkw4eXFtaGU4QlFPTDJ5WHNoVFZwU0lQR0Uy?=
 =?utf-8?B?dGhCNVRvdC9iMUFCS2tKNmZIYTdkOTNZdFpneTdRYVAySDBob05MZkxvZ0dZ?=
 =?utf-8?B?eTdKY0lNblo0WVpENWVoNHJzVDFEWVBhcmZRd0NvSEhFNEJnRjA3MmlVSzdu?=
 =?utf-8?B?QkRwYnRpWVdkYlB3Ritwa3JCMi85REdxTk9nNm9KTWhNNzFlMXMrb3Z2MXpD?=
 =?utf-8?B?bEtUL1JFSW5aclQ1eEtZM1ZyS1FtYmVzREdiajdOUWltKzhFNlJlbkxKVzRr?=
 =?utf-8?B?VUxmOEtmVnpaRGt4N0xWSTFoa1ZKcGx2QWpxSVo2RXkxNldibFJuVFFjL0lF?=
 =?utf-8?B?ektKM0xhaWlxVndDa3dVYlpNR2F6TkVlN1l3bTZ3OHRETEJVQURSNVVlU3Az?=
 =?utf-8?B?ZEx1MWpUa0p2VTlCdXp6Y2NJaWxnaDJmTDhUT0JCbWU5QmFnNzlUNlh0Nmdz?=
 =?utf-8?B?SzZPOGpUWUZRVldLUEdEdHFyMk9HakYzT1JnOE1KVk9LUjZqTzZHWGU5ek1N?=
 =?utf-8?B?a0RlVG9tMm9vbllDWDdvS21sWjFtcGt2Smx0U2FxWmlTSUI2ZkNjQW9Dck1i?=
 =?utf-8?B?L2N0cVI5SzRUYlptYW1zV3NqVnk2Slk4aWNZU09QckFiaVBPOVh1UGRKaFd5?=
 =?utf-8?B?RmNCUllnL3habGxSSm8rcEMyb3hpY21sSnV0TFU0c3dRRWdWOWxlcytDYW9C?=
 =?utf-8?B?Nm1FMDNsQ2VMa3p1VXNaS0MwbXBaSDJ3VnpSK0M1dnRzdi9KU1o4RXpEMHVu?=
 =?utf-8?B?ZitWSmc2ajZWVzlZOGJ3aWpNMC9LMTl6ZHgwZDdjY3c5UWl1ZkhITlFCelp1?=
 =?utf-8?B?a1luS0NOUXRxRGFWVXVPSVNQeUdhY2ltQ3pZbHNLb1RVMkNGS3dUVjdiUDla?=
 =?utf-8?B?dC80Yi83S0EyMXZ0eVo3TU1ia1kyWVM1SU1qa21OajNhOXRueVFHbEVIc3hi?=
 =?utf-8?B?SW1JWDRzY1M1NWZxVEV1cFp6QjdhK2h1TVRtUy9RRVJ3KytjSjhOYk4zRENk?=
 =?utf-8?B?ZUlzNE92bXhtazV0Tll1c1A1cnpVZE13MFd0TTJ5dWlmT3h6WEZXSFFFaDEv?=
 =?utf-8?B?SkJyRnZ6NS9DQTF2cDNtRlZBQlpvbHVLeTRQMHcyLzJWMzcxVEI2dDVlczJl?=
 =?utf-8?B?OUR0NmNYb0NWblJVSzBCdCtOZzFnaE8rOFcxS1VpUXEyZVlzODNNdnJoMmpH?=
 =?utf-8?B?cDhPdzMyVG5YVWhEb1Q3OUNwVFR6enFnS283MjlhRW11K0R3b0ZHaStsUkcz?=
 =?utf-8?B?cEgveHpMdnprYjkwTnFHTllMdXh1L0MvaUhGYjdxMDB5dUFLNGdWN0M3OXlw?=
 =?utf-8?B?VzFBaWIzYmVaOFN0WTB5SVR5RnorKy9ZSmJ6YXhYbXMwSGdBRGlucVU4aFZp?=
 =?utf-8?B?V2tlMVR2aFg0ZTliS29RVCtUWUxST04vdDVKK1BpNFVaUW8rZkFoZWR1UG1G?=
 =?utf-8?B?RXJCeHZxSGZ3N0t0R2V5RWJQMi9QRXdBaktUQjZXRmZJK045d25qd0t0ZDdm?=
 =?utf-8?B?TWhyR00rYUVMUlplSFU0M3R1T3lxZmN3THorZk5ZTzEzZmpXMFl2WXFoeExY?=
 =?utf-8?B?MHRDRE83NnUrc1dBN3VyR01xcDNYUFhoSFpaK00rbWhMdjVEeGZmRjVucHRE?=
 =?utf-8?B?R3cwZGp5c1YzN0t0T2w4aCtYdCs4dEFmeXVMbUhOR2NTZ0ZKVTdwbUxvUy9s?=
 =?utf-8?B?T3c1VTdrNGhIdnBJR08rWFBVUXZSdHpHemducE1GZXBUWlRMcnU0STNlZk90?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c505110f-c5df-4e13-2d8d-08dbbed971df
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:42:13.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sx85kzjWqN9RKVR2iGEMN6vUGWRhGWfln4r43j+gzc2Gt1RAG3Ysnv+9TDWyLVPRI7/og2Mzuu22vVXfdn+6wE0WDFPYrvR2eOpcWVYuumQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2023 11:44 PM, Linus Walleij wrote:
> On Tue, Sep 26, 2023 at 12:29 AM Jacob Keller <jacob.e.keller@intel.com> wrote:
> 
>>> +/* MRU is said to be 14320 in a code dump, the SW manual says that
>>> + * MRU/MTU is 16320 and includes VLAN and ethernet headers.
>>> + * See "IXP400 Software Programmer's Guide" section 10.3.2, page 161.
>>> + *
>>> + * FIXME: we have chosen the safe default (14320) but if you can test
>>> + * jumboframes, experiment with 16320 and see what happens!
>>> + */
>>
>> Ok, so you're choosing a conservative upper limit that is known to work
>> while leaving the higher 16320 value for later if/when someone cares?
> 
> Mostly if someone can test it. But maybe I can have authoritative
> information from Intel that the statement in the Software Programmers
> Guide is correct? ;)
> 

Unfortunately I'm one of the folks who worked on this driver/hardware,
so I can't comment.

>>> +static int ixp4xx_do_change_mtu(struct net_device *dev, int new_mtu)
>>> +{
>>> +     struct port *port = netdev_priv(dev);
>>> +     struct npe *npe = port->npe;
>>> +     struct msg msg;
>>> +     /* adjust for ethernet headers */
>>> +     int framesize = new_mtu + VLAN_ETH_HLEN;
>>> +     /* max rx/tx 64 byte chunks */
>>> +     int chunks = DIV_ROUND_UP(framesize, 64);
>>> +
>>
>> netdev coding style wants all of the declarations in "reverse christmas
>> tree" ordering. Assign to the local variables after the block if
>> necessary. Something like:
>>
>>         struct port *port = netdev_priv(dev);
>>         struct npe *npe = port->npe;
>>         int framesize, chunks;
>>         struct msg msg;
>>
>>         /* adjust for ethernet headers */
>>         framesize = new_mtu + VLAN_ETH_HLEN;
>>         /* max rx/tx 64 byte chunks */
>>         chunks = DIV_ROUND_UP(framesize, 64);
> 
> Right, I fix!
> 
>>> +     memset(&msg, 0, sizeof(msg));
>>
>> You could also use "struct msg msg = {}" instead of memset here.
> 
> OK
> 
>>> +     msg.cmd = NPE_SETMAXFRAMELENGTHS;
>>> +     msg.eth_id = port->id;
>>> +
>>> +     /* Firmware wants to know buffer size in 64 byte chunks */
>>> +     msg.byte2 = chunks << 8;
>>> +     msg.byte3 = chunks << 8;
>>
>> I am not sure I follow the "<< 8" here.
> 
> I actually only have this vendor code, but clearly <<8 is not
> "multiply by 256" in this case, rather that the number of 64 byte
> chunks is in the second byte.
> 
> The software manual just describes a "OS abstraction layer"
> used by both VXworks and Linux, and since that wasn't acceptable
> in the Linux driver, someone has ripped out the code to
> talk directly to the NPE firmware, and that is what we are seeing.
> If you have the source code to the abstraction layer
> "ixEthAcc" or the source code to the NPE microcode, I think the
> answer is in there... (I have neither, maybe you can check internally,
> hehe. Dan Williams used to work with this hardware!)
> 

Yea. We could use FIELD_PREP and some definitions, but I think its ok as-is.

>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Thanks!
> 
>>> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
>>> change-id: 20230923-ixp4xx-eth-mtu-c041d7efe932
>>
>> Curious what this change-id thing represents I've never seen it before..
>> I know base-commit is used by git. Would be interested in an explanation
>> if you happen to know! :D
> 
> It's metadata generated by b4 which is the tool we use for kernel mailing
> list handling:
> https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1
> 
> I think this change ID cross-references mails I send with my
> git branch, so it's easy to collect review tags etc.
> 

Neat! thanks for explaining :) b4 seems quite excellent :D

> Yours,
> Linus Walleij
