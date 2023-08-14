Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BF77B7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbjHNLba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjHNLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:31:18 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9ED127
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692012677;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Xd2zTVybbsUnv1bMmChePGImllG88iUXcDhMKuKRMw=;
  b=eTbfwQNvfT2EgaIkahw8sondJ2HzBT5rDdft77ahNyPrncAEySgVfh9y
   nxeGBqUN9ESQbKkJiXjZuCZFGorT4PWKWrshw5n/+qKSWYiGF2z0B3a/T
   qGJylM0r3eqpW0dXnXTDrTMedX6c31pZLnnqyGduG4Zzd6n4x5m1II+1v
   c=;
X-IronPort-RemoteIP: 104.47.55.105
X-IronPort-MID: 119852439
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:jV0Kd6zp14kxwvFqbWF6t+fGxyrEfRIJ4+MujC+fZmUNrF6WrkUPx
 mFKWWmDPv7cN2qjfI9ya9uypxlV6pXXztFmHQVqpSAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EoHUMja4mtC5QRuPKwT5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KSJM9
 Mc9BhwuUhKagKWKxLe4U9RXqP12eaEHPKtH0p1h5RfwKK9+BLX8GeDN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvjWVlVQsuFTuGIO9ltiibMNZhEuH4
 EnB+Hz0GEoyP92D0zuVtHmrg4cjmAuiAdNCSefkra8CbFu760tLBRRJUFyAo+CbtkqkRspQA
 XA/5X97xUQ13AnxJjXnZDWgrWKJpAw0WtxeCeQ25QiBjK3O7G6xBHADTztLb9EOt8IsQzEuk
 FiTkLvBFWwxmL6YU3SQ8vGTtzzaESwUK3ISICwJVw0I5/H9r4wpyBHCVNBuFOiylNKdMR353
 TGG6gs3n7Eai+YC0qn99lfC6xqjvJXGTQ4d4gTRQ3Kr6R5/aIe5Zouur1/B4p59wJ2xS1CAu
 D0BhJKY5eVXVZWVznXVHaMKAa2j4OuDPHvEm1lzEpI99jOrvXm+YYRX5zI4L0BsWioZRQLUj
 IbokVs5zPdu0LGCN8ebv6rZ5xwW8JXd
IronPort-HdrOrdr: A9a23:S3cZzqH+UWzMCBXfpLqELMeALOsnbusQ8zAXPiBKJCC9E/bo8v
 xG+c5w6faaslkssR0b9+xoW5PwI080l6QU3WB5B97LMDUO0FHCEGgI1/qA/9SPIUzDHu4279
 YbT0B9YueAcGSTW6zBkXWF+9VL+qj5zEix792uq0uE1WtRGtldBwESMHf9LmRGADNoKLAeD5
 Sm6s9Ot1ObCA8qhpTSPAhiYwDbzee77a7bXQ==
X-Talos-CUID: 9a23:u/QX12EDmLVfK9T4qmIk9k8vP+4JUUHf1XCXH0u9Cn9Uc5OsHAo=
X-Talos-MUID: 9a23:KugLuwr11Sk4yLipGfEezxxFbMphvKGpM0IUs6kCodScOgZMECjI2Q==
X-IronPort-AV: E=Sophos;i="6.01,172,1684814400"; 
   d="scan'208";a="119852439"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2023 07:31:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3Dr3cZatygXgLYHbRSfmNkKYoKFiQ2i443ZcQgJv9B+EWPgg0LpObHG3pvHwACSJpI6bzR8yHgiM+9EYILe3c/Rrzr+VLMXU65ZjbUwXrHR9XzmVKfRAwqTBk7y5jqcKsZ74qE1beXcYNXCyw09iP2sgJt3lNlVxleF9Z+rS2Nhu6Q7xD/WiAHa+fWr4in0zweRzICXfaArI2I1RSK1sI/nqJaetVRvLdhjI1ncOpKBuN/favdzGywKcUWewybGoC82ZLkKYJ+26JyZ8tW/OY6418Ifw+dw8DzZLeQo3z5fc7mCTxvp9AGWT9fXPgO9ZvUuxI5Zd1G6xBlhMI7AkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zYRUA8DhVqfhyt3UVDG1YFwCiL5TAVdYXFxCftEcqM=;
 b=WjRdm6vS2YZa2GOdUQGm/xkJOQnpeY4FRKDboTZohq1+wh8kDJ3G99GdaFS8X9S0yWxyeR/fdMrZI3AchYNaKtTgAUtNnHkABt0bcD5ucHzyb5bOJ0sPLeapNLUyxWox/vuGPIzrZEtMKnVAPbYgPM7XaXAbPLKv8j/Kz6OOY35Tnu8Bh5CBm4w2h75S0nc+xUZR1TCLteJlFWFMlnXRdqYzrvwVrd1x+RZuzD1Ou3dm4s9q38QXVbhShALEx+lxZgWoIzDspjFecWuMzLqjeGgf7BKN7BADmrn5OGRXjSHBMr+6RpoUgykvNtWHzFeqvzi7C3nsKIwCFjPR2a+flA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zYRUA8DhVqfhyt3UVDG1YFwCiL5TAVdYXFxCftEcqM=;
 b=UTAyusU8DIidf4ME8q9+4CMfcXLOFvG+zHIQeBDPVbUzajcWE/ZmvvSyNJqZnw55esQlzBlO/GngQ2HsFYoTzcWidT8Vv5bNWXo66G/oBAgrv2kASeQ6+amYYn5RrrfEWnML8roB36n8mGLhH41UcKpaz+7q9VFyje8pqNU/18U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB5599.namprd03.prod.outlook.com (2603:10b6:a03:285::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:31:11 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:31:11 +0000
Message-ID: <b9d4d252-0fed-a4bd-2bc9-3c8dec6b9622@citrix.com>
Date:   Mon, 14 Aug 2023 12:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew.Cooper3@citrix.com
Subject: Re: [RFC][PATCH 12/17] x86/cpu: Rename original retbleed return thunk
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
 <20230809072201.259675763@infradead.org>
 <20230809142031.jkj4pa2mhccrdmmd@treble>
 <20230809142255.GQ212435@hirez.programming.kicks-ass.net>
 <c4c1c9b8-9ced-7282-718e-48e14375e9f1@citrix.com>
 <20230810130229.GA212435@hirez.programming.kicks-ass.net>
 <bd670c70-47f6-efc7-6ad2-cd833b414ec1@citrix.com>
 <20230814103437.GC776869@hirez.programming.kicks-ass.net>
In-Reply-To: <20230814103437.GC776869@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::14) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SJ0PR03MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 059ee99b-956a-491b-d814-08db9cb9f4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wxrgInLN8DiGKCgrYL8NQkNESJCx6Ksoe5TLDT8d714DJUQ094yNRocVDYCi6KwH/8Ycq5zFb25bp9aizH5glNxUfCZJscpfGuOQ7GI7ctNWcZ7X4JYfR9POsYMMmiAkiED7vnT8YMVmFg1+OBdvZSl81Uce/vHhQEoGGaZNCKWGUOs4Yb3yosoZCPEjFODlQ6hMT2U6PhFZqun+moZXlZ+g3vDw0mIwYFjgvURAprPfZEROjJ4z92PM+jV7/M0RSJs5OkmRoTZOmNwCsLY3EfqEqZqG+PDr9ub6rbhPFgET/Rl3N8I8iaM+14nz3gsPPnan5M/WcQZL3836uLf/7GZsTyFuvICnbngJ0aLsSH0bR6D22nqyDoCzfs1lP7SoUToBhrRJtOUX0nZwHO0fNg43WCuY+Sdn7tpWzZr9hm6zsydg/uNgrL2HZoS2owxGndsQg/0MGBaTr2+XVOmebqP8nEZhyTJnh4ehzjz+UrzfQ5lDESyGGquduiDvDkgSHaPdfDHNMx2AA7DV5HUAXEA83y+nKrN5eEq95B7L6GoLAbO33EmZ77pUsH7huNnApoGK0fNep6WXsU1ylo9KqPDZQKM4FNKG7s4AuN7C6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(31686004)(6666004)(966005)(6486002)(6506007)(478600001)(82960400001)(66574015)(36756003)(86362001)(31696002)(83380400001)(6512007)(26005)(66946007)(53546011)(2616005)(2906002)(9686003)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(8936002)(6916009)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW54NXAyUkZoMjVWL1UyYWh3NHB1dFdMSWxrTVJFNFlyQVBJRFNzS1lCRXhM?=
 =?utf-8?B?RHVJTXBHZmdwUWhwazZVZGthT1V5SlVxdHJvQlBUS0IyY1ZrazVqdzgvdXBy?=
 =?utf-8?B?eXhkNTR0T1VLZys5a245QUN3WktUTHJNVWpua1NyeGdvNkt6UVlaT3JYQVhI?=
 =?utf-8?B?cWlQamNSV1JzUGJEUDA2ZmlCbGhoVXlidUY2ZW1sVFNUOWwxamZaM3poMXd6?=
 =?utf-8?B?aEUzaXZIdGQxeDRnMmJYWW13dlhVWHRvTDJ5MEVDSnltVWw4aTRlM0RSSFBY?=
 =?utf-8?B?NS9vRXJTRzQvUC9hblk1OXpXaEE0S2Z0L0FjUUM1bmI5WCtwdGJlR3hDRC95?=
 =?utf-8?B?RmZLVHNpYlY1dnFCQm1QVmpEYm9SV0pzQ3dMUlpMNXJuNzFndktPRVAzMExN?=
 =?utf-8?B?clJSR1VHUmtiRENOQUZvR1BEc3ZadGFkQ0FUUmtpeHllMFdjejgzTk8wQVNX?=
 =?utf-8?B?d1VGaDJZZlFqRERMYU9obVcwMnF1YmUwOXRZcXRmRG9IbHVFOEw2ak91UDYv?=
 =?utf-8?B?L1JHQmo1QnlFdmNlUnZoQXNnbmY5WnFaNUlFaWwrNVZtT21NWnIyUzBWYkdL?=
 =?utf-8?B?c0k3TEdWRDhqcmpPeEVVdFNha3BsczltdStJNmVZMFRFZ2JNc0RQWURmLzVV?=
 =?utf-8?B?L3JkVXYvU1NXaVRQMnZld0E2R0lkWGFFcWpsTFZFT2NoVDkwZU5LWFhqbEgx?=
 =?utf-8?B?b01XYlBZczAwZjdtaEx5dDBVZlhKTzk2SyttMFhDOEdWS3VwQ3Rad3loSHpP?=
 =?utf-8?B?Y1Rsa0dlbG5qa0tPakxiN0FGbWN6NDhVSVo5YVZEZUdqWHR3blAxam1TeFph?=
 =?utf-8?B?eVZZdUFrUnpGdmdaWTRnQUZTQTVNSDQxSWFhZE9XcEJ2QnNtZUE1VVFSaGM0?=
 =?utf-8?B?REgzd2NLOHk3UFhueWkwWUZob00vSmlwd0hQWk9IYW9WaVJrQWEwQjlOUHAr?=
 =?utf-8?B?bUNOeGpHWUx4TWdTNVV3VFRhT014SG9zL2VSWVBXUlZCK1l5N1BPUFZaU0lI?=
 =?utf-8?B?SjNsaGJVNFgwL0NUM3FuNWZXRllJOHE5Nk1UUHpzREFGNE5vVG0yMTJDWjJI?=
 =?utf-8?B?Q0srUnR4NHB2ZHFob3B4RVg3dDF2akNTZ0F4T2tIQkk4azZqS1ZVMkFER3Zh?=
 =?utf-8?B?Ky85Uytwc3ZrVHZ5b3JNK3d2c2FoV3F3Q0h2cTJjUUVvbTRJUUNnL0dUTWlx?=
 =?utf-8?B?SENuRmNsb0w0cUhyL2VIdjltTTlZRktYR2dVY3l2cm9VN1h1Uno0bk9sS0dB?=
 =?utf-8?B?YXJaSk5WOTBrZ2pHN2RBc1dYQjdYWjhSd3J1eE9SWVhsc281S1dsMnVUYkRB?=
 =?utf-8?B?MHVlcHRMb1k5VkdISDBLcmxWSU5sWHFxWDZJa1NTeWg1c2N1cUlSZS9WQXBL?=
 =?utf-8?B?Y05ab1FGNGRHL2wvcDR1dGJsaS9TVUF1RWtIblo0NU9xeDYvT1N6d3UzV1Ez?=
 =?utf-8?B?MG5VS2lHeTRma01PZzhQeG5tQThPZkNnNzhZaDdSWldXaHVjSXYybU1tNGJL?=
 =?utf-8?B?SFduekFQZW1Wb0tnaEFLMmp1NkVVeU1jQlAybjhOV0E3UDlEOHNUMWMweHlt?=
 =?utf-8?B?dGpiRERGUE9pRThST2U3d0hhRklzTkcvbmdtNzFWRVRacUw2dHFoTk5xWVM3?=
 =?utf-8?B?L0R6YXhhVTFsd3FnMWNKZGZEVWt3RnZqOUhaVCtUdkROb3pPeXhVOElQaDVn?=
 =?utf-8?B?UWZ0a0xMaFcvSGpZNlBLVEV3RFZTdENpZVl4emthMDA0ZVNjUnN1VnVmVURs?=
 =?utf-8?B?a0tPRHRDY21EV2F1SDhNajFKTmlFRnBxcklpVzZ2RFkycHJrOVpPcGNZZ1A3?=
 =?utf-8?B?UVVZdjFZZGVvc1J6VUNpZ2lVSjRXVENBOVJpcXplelhKU3AreHpkeUNGT0Va?=
 =?utf-8?B?RDF3cmp1TFRicnhzNjlsbXNSREQxVW9CTXp2Unk0b2xMLzhMZUpRVHJlZlJY?=
 =?utf-8?B?bllhZ21ENklQcHF5N29oZXJ0TlBKRTBmZW5zWE11MGl6VWFOdnBUNXJoSnQz?=
 =?utf-8?B?Tm5EdDJLUVE3bndxb056d1hXTXJHdHJ5RnQrb1BETHQvVUY5R0NYYW01eXVr?=
 =?utf-8?B?blM0Wk9LRDFJZDQvQ09ZdFN6YUdWSFVySHA1bm1yQld3RjU3a1VJWlZLVlIy?=
 =?utf-8?B?WXpBNCtnQ2l4dXp5b1JweS9YVTVoU3pLV2ZCZUttODNHQ3phVWMzVDZpSEQz?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y0yXbRkIYDr4ft0Ioc2rUC0frnbGV0Nalx3io7ONq63Kck9x+O5eOKVSqyCPMWu4EBhmPuWHO9oYv9hJ0u4+ryzmP6Kf4MvxfXGlVtRRhJEymkF4I63xlGdkbEnXnX5M6LQT+g++wnzbzD8WMFcnf9lxBoeFDsb1Cq3irE9Nx5HzrbyzgL075cqTbsJn22simlSVB5Konau8z3ayQePvKNdcP2BvFa5eJpD5rhR+0xJYvqU9LfLTKisJYfqOUrpN8d8vZGQSQyBtTa+MOI1K4VQcwmpkJvijIYA3BUg5/+Wc1FyTfCBp4ofRRp/7QUcVKAxUKHXJqJOzp5thXXuYTlwX8kYuaDG8LKt2rFvZ0O/k7X3GLw6u24KbgZGZFe0VPFe0VsmnyW8MubEjASltKirwaT7M0WyNhiNuQAbgaGoYwgbgRBiaT8hJxNii5nos7ZUbbtyuz/VQBMxwAjc76Pg+Po40mOPX/xlOGuW/nqRsA4SLiLFsbgb9bCHx3BcLMQuy/kZ7U/f7VNOeVIic8smK2nL6ftNVXC/vY6tJgZHdohayCYbIMk2Z++eH7VEAQ5lOi6R8XZB3IVYmQaqgcF80ktJpufD4E9a2sWgDwdPQBYm338xruv7EiRL036L959niP1aa7Q0F+cXd4zevb3XhL7S3XGDlHg03vz5axAsG9nva3v10TbM9w9yG2uJqKgGRlSm3QZd4gRIpNCmBIgu+BehEIW4tCGTNWZ/v+VoPxf462IGKQ4ynteUZrttOhF0pFTb2Pof7vlsYwArE3LnTnRWBXtZGySiIeYU03JzOeSdAMCjJjIykRarneKwgaH4reOAuzU59SrL6lijAEf+H7E6yjl+AUktxFf1DKibpC3ShbCabnNmz7pPc2CphFTw/vDKOuPVZ1wEi2Sc5OA==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059ee99b-956a-491b-d814-08db9cb9f4de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:31:10.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OpT6CeyclskMH8MyjjayflMCcENVem/h3uEuVZq+FWlyOtU9dT9i1HX/GdP78gx4FHjG+zjRm3O1N07QBh7NP7IWGpBCZnMHUbPYP5U1ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5599
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 11:34 am, Peter Zijlstra wrote:
> On Sun, Aug 13, 2023 at 04:23:27PM +0100, Andrew.Cooper3@citrix.com wrote:
>> On 10/08/2023 2:02 pm, Peter Zijlstra wrote:
>>> So BTC as a whole is the fact that AMD predicts the type of an
>>> instruction and then picks a predictor to predict the target of that
>>> instruction, no?
>> No.
>>
>> "Branch Type Confusion" is the technical name AMD gave last year's
>> issue.  Hence the name of the whitepaper about it,
>> https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion.pdf
> Bah, then what do we call the actual underlying issue that the AMD
> branch predictor starts by predicting the next instruction type --
> before it has been decoded -- meaning it can predict it wrong, which
> then leads to a tons of other issues, including but not limited to:
>
>  SLS through JMP (or pretty much anything else)
>  RET from BTB
>
> ?
>
> Calling *THAT* branch-type-confusion makes a heap more sense to me.

You know the branch predictor being ahead of decode is a property that
exists in both vendors CPUs and has done for more than a decade
already?  Bad branch type predictions are relevant for a number of the
Intel issues too - they just don't talk as openly about it.

The thing that missing from AMD Zen2-and-older CPUs is the early stall
in decode when the branch type prediction is discovered to be wrong. 
Intel have this early feeback cycle, as do AMD Zen3 and later.

And yes - this is why SRSO is not an extension of BTC.  The
micro-architectural details are very different.

~Andrew
