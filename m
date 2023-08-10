Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7865377767D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjHJLGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjHJLGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:06:30 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D50B213B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691665587;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wDn4+7OiKr3gB6NzWTbPXS5l1nwsQ3g+/OE8YFNoSmg=;
  b=LO5gieMtPD19rAAEFxYYEhZjABymszAc0Mw7qLZ/hrxQHur8vOkC1RrP
   G4FINONTsOQQ5OkH8Vf2K7KI/r9/FyiTm2fzVyj8aadGNIMQt+XCs96NM
   DlCfFhFuq6fl0EgfN5zeafr8OYP65vnnDjSUKzYo4BGDlKOoKyt3+An5+
   Y=;
X-IronPort-RemoteIP: 104.47.57.47
X-IronPort-MID: 118981710
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:zA9TD6+SH+5PNTnSiPBbDrUDdn+TJUtcMsCJ2f8bNWPcYEJGY0x3m
 GdOCj3XbqyPYGr2L9F+OYi29kJU75HVn4Q1HAQ5qXs8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks21BjOkGlA5AdmNakT5AW2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklt2
 u4oeS8SbyyDvNOo+LaGbK41j/8seZyD0IM34hmMzBn/JNN+G9X4ZfyP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWMilAuuFTuGIO9ltiibMNZhEuH4
 EnB+Hz0GEoyP92D0zuVtHmrg4cjmAuiAdJDROTnr6YCbFu7+Ug0Ig0IdkKBmNq6qFHnZvtND
 W4t9X97xUQ13AnxJjXnZDWgrWKJpAw0WtxeCeQ25QiBjK3O7G6xBHADTztLb9EOt8IsQzEuk
 FiTkLvBFWwxmL6YU3SQ8vGTtzzaESwUK3ISICwJVw0I5/H9r4wpyBHCVNBuFOiylNKdMR353
 TGG6gs3n7Eai+YC0qn99lfC6xqjvJXGTQ4d4gTRQ3Kr6R5/aIe5Zouur1/B4p59wJ2xS1CAu
 D0fnZGY5eVWV5WVznTRH6MKAa2j4OuDPHvEm1lzEpI99jOrvXm+YYRX5zI4L0BsWioZRQLUj
 IbokVs5zPdu0LGCNMebv6rZ5xwW8JXd
IronPort-HdrOrdr: A9a23:qp2Bzapc2UbX0LiMFeswAjYaV5tuL9V00zEX/kB9WHVpm62j5r
 WTdZEgvnHJYVkqOE3I5urwRJVoLUm8yXcX2/hjAV7dZniFhILAFugLh7cKqAeQeBEWmNQtsJ
 uJeMBFeaLN5TARt6rHCGLTKbkdKBbsys2VrNab9lMoaTxDL5hn6QIRMHfoLqW1LjM2e6bQ0P
 Cnl7p6T//LQwVnUi3BPAhgY8Hz4+fTkY7gY1ovHgdP0nj2sRqYrITiFgSe3FM0TzNLzN4ZgB
 X4uj283Lynr/a4jjjV02O71eUwpPLRjuFbAdCKiIwyNDLhkW+TFeJccozHhikxvOasrGwLvb
 D30m8dFvU20WrVYma25SHgwBbtyxEn73OK8y7ivVLT5fbhQS48CY5/iZlCch3fgnBQxu1B7A
 ==
X-Talos-CUID: 9a23:1S5J9WFDLD/Dd4WHqmJE21wkS986c0Hd90bOG0uFLyEwQYaaHAo=
X-Talos-MUID: 9a23:eLrNSAb2fAekxeBTiBvLriF8F95S2oetKl9UrLwUneu9Onkl
X-IronPort-AV: E=Sophos;i="6.01,162,1684814400"; 
   d="scan'208";a="118981710"
Received: from mail-sn1nam02lp2047.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.47])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2023 07:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST3sUDbJjTfp11HySED6Gt3M7S+Q1mvaX1t846z6c1Vigj6KJy5PPEKMqcEiaFNGlxkuA+7u1nF8sCfDVXRE1J+2oHXhX+mcTRNOb/qJXvT79yDNjpO9mETmZv45GJyWG/o99briB9GxrhtfYuFW2S+BgFJBMGb4MmNt+PiVJ2y29woOqvnp1O/iYHE2UYnsWo3+FKdWqL4D+3o4XYymU1my9IaMZ4VlkM72UnSbsfVd9XYtwm8C9Iqsg2VBftpemiQZqZVnFyAdrs4X8OoRnpUhjC9UO6ix2D0taLj0TKxeXqsB1jxnhbIHSUacEHV5uJbg0L2W1mmeVD8BrovSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIPGo+dWRZzzllp63zEADTsVYlC9mHcPwvKV1TteLwM=;
 b=oc/QfcVgRqVnXaYYsrxw2RGsqRx2sBtmo7wgTS/6BK3C4/jHGz8/LihSszzS+Jgb4BEWocIe+zu2swJj+JtR1lxQK8rADNqeUag7Z2J9PHAtrDDLAdTfQmkgUwzIeSMxU7NTC/3T+U/CUDlyJW4gHnilFQe4hzZcCfl15vpq4dr92A23ggKGY8gjYRImpcH1Wr5NlV7Zq1i4iW9yDGkRnyKs2tWr1qaTEkgHgmOZoB936NL1k2dozCCDHHQfFYxkP1rMdTT9bOJbkSdB70RHmcmkz12bQOjp9ORG9OdEKhBPIwGLDTQdRk/QPjVHaxZ0+yku6+y8g/cSj2jEd2kJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIPGo+dWRZzzllp63zEADTsVYlC9mHcPwvKV1TteLwM=;
 b=ttfSgph880FmOiwBCjZBKIX/x1UR/h83J4dhcN/4rqjFFDXBldFSDHTC1hsVvUgOQjhzucCC0za/ldEF9lyXxVUiNzPltbUyXj83qZkwb87PhMbZE4Z5h+G+Fx/BWo2cQ0NcIceqgCxJL+iQgSIAUiJXjo35vV14JKR7PLXhu5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BN7PR03MB3618.namprd03.prod.outlook.com (2603:10b6:406:c3::27)
 by MW5PR03MB6908.namprd03.prod.outlook.com (2603:10b6:303:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:06:23 +0000
Received: from BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::8f94:c73a:ffb7:d5e2]) by BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::8f94:c73a:ffb7:d5e2%5]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:06:23 +0000
Message-ID: <c4c1c9b8-9ced-7282-718e-48e14375e9f1@citrix.com>
Date:   Thu, 10 Aug 2023 12:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew.Cooper3@citrix.com
Subject: Re: [RFC][PATCH 12/17] x86/cpu: Rename original retbleed return thunk
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
 <20230809072201.259675763@infradead.org>
 <20230809142031.jkj4pa2mhccrdmmd@treble>
 <20230809142255.GQ212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230809142255.GQ212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0452.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::7) To BN7PR03MB3618.namprd03.prod.outlook.com
 (2603:10b6:406:c3::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3618:EE_|MW5PR03MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 883d9ed5-a640-4da9-b7cf-08db9991d4f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eLyRoKSYzhsPc+7giS81gYvvMSUWecgISvhAqRzKo2vQ+JVitLWYla0SQiczT2XpwSjJ3exrizARGrlf4nSp9tOfQcnwiXiajjm5UPHOk/D+3ad0dP0x91x2VI1Zu9ZWNOTchHyy2IJdYZVuUWazFilMF/plwtFJz0+nyYpDq3gF/LWsMRXskYd/Ti8aPjBdkV0Rg2A4/O9adVldfteJBiCWvI+5KkO5tof8vJk2AGy1ZcX6hjxVIO8Oer/uhyLpJPIy2IeMbiqx8crSV/DlEKsjkib/A9+Bxzc4RbwfR6YuAe7GNpkTwOKexvlQlyw7Ti49illJNOLPTiArsIqcDVGnsdfsDvja1JqYm7WtovE6aYQKuBkbK59WG0RbRDAoLSEU9BlwbDGPrkNa0rbHet85AschzUYHggO+ynhzkIZk2TdioVwJJuq85cx8npiDHOMpbuvwzPvmG+/NFXxC7aR86jYzzJutu67jj+6Di8wSa5s5hh1vJi7M/dn6w6+d/7KzXn6V2F3OqWU2ApQPeviprcXUn/eAF+xtKsBRX2nZ2maoY/MD0NseDIlXeIdYYSC/XkiKpt4P9/70mDs3tZKl9MlBRipLHI/Nrmcllqw/ZKw83i9faugI1NOlbWY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB3618.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(1800799006)(186006)(110136005)(478600001)(66574015)(53546011)(6506007)(26005)(2616005)(31696002)(86362001)(82960400001)(38100700002)(2906002)(36756003)(6512007)(6486002)(6666004)(9686003)(316002)(4326008)(8676002)(66476007)(66946007)(66556008)(41300700001)(5660300002)(31686004)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek9XUFNlNXhHbmk5M3ViNStDSHVhNURBa3FvR0wzMC9yajdtN1g1bnlYd0ZL?=
 =?utf-8?B?RGoraG5lb3YrditkTWpMMnYxOWpkUWFQUCtES1hUbUF2SnZIVjZycHg5Zyt1?=
 =?utf-8?B?UmdwMjROYjQ2UnBzZnZLZkNwMVNGeEwyNlRJMHZPMVpGMmxHc3ZORWhQdmR4?=
 =?utf-8?B?ajlMeWplN3ZjTHJzYzZGVDNoMW54S2FxRHoxdkFFcUVHcFhpRVQ5YjBsOXcx?=
 =?utf-8?B?emNIZlc5a2MzcmR6WFUraUh6MTdOZVp1S2I5OUZPeTRpNUZFV1dxdjBSV0F3?=
 =?utf-8?B?dVpDSFZOSEphQkExcnBqb1p3QXVmR1Q5bHU1b3MzaS85RTgxaThIMGlwQ1A0?=
 =?utf-8?B?WDQrQ3cxNXhMOXBDNEQxa0pxTFlKSEl4M21IdEhMMThBZDJPUlhDM3VmL1VM?=
 =?utf-8?B?ckErRVRqZmZxcDVYdGxmeWVybnpiNFo3RHk0SHZ5V0hnNS9YR2EyN05yRUNC?=
 =?utf-8?B?YTFTZitwMWxvWGF4UFpBZUE3V0puUEJMa1Y2a1dEM1VjK2hqTjlqdk9OaGp0?=
 =?utf-8?B?MnpsU25pamRvclpGTWlEYWVlVGZYc01nR2pWaUtHOW5zV1RCZHUyb3I4MFZa?=
 =?utf-8?B?YzVzalNqalR1aVdpaGFhV0szNkowU09BN2RHbXg2OXJOdXNEeXZUb0hwc0E3?=
 =?utf-8?B?cU80azE3MnRpTjhmeWRTd1poSElIdm5xU2RpMTR1K3RNdEZmTHA2MVBqQjds?=
 =?utf-8?B?OG1jQzdmdnIxUUljQ3oxYjNkbnRRd2g1aXlSYTJBYWwrYWRrLzE5cGxYR1Vy?=
 =?utf-8?B?aGE3Z3JXQ0I2Y0xISTVsVmZnZ0pSU3Q5VnMwTHcvMXdYaFlWSFc3eG1ja1lK?=
 =?utf-8?B?YnA0Y2dFVnZvdVB5d2ZMTnZQZkQwaS9lNC95TElkWmIvYkhCZkxiNmpYZkVl?=
 =?utf-8?B?UHR4TWJoSnM2cnloeHZFSE51di81b3ZjMjI5ZUZka2lNTVIxK2E0UlFqSlA0?=
 =?utf-8?B?MWF4R0NDVWtzWFZwZW1Dam5HU3l2cXZEcWR5ZHdyS2hhckRjMUx0MTFVc2dv?=
 =?utf-8?B?TGN4YWZTZnhzci9OMy9PejA3V0JYR1VnQVNxaUUrUXhrVkxjODhSZG13d24v?=
 =?utf-8?B?ekM1ajZ2R01jVEMzd0g4eVQxRVNHS0o4M3JJcHBtVzB2S3JYYXgzemJRdHVB?=
 =?utf-8?B?d3Rhb1lKVTkreDAxdEZBRnVsOHVvR0lrSVNNL2l0QkV4UjhxcTVRbXNTMW8y?=
 =?utf-8?B?aVNoSEdZQ0JlbEVVTDlTOGZqbGFPSVl2SUY3ZitFdW85bEdrTGEyeUR3SGJ6?=
 =?utf-8?B?ZEVwTm5aN0l6bnRQOWUwOXhOTS9jZEJqVUEzVnovaGxKS0lwZVVNZ1VtbmlV?=
 =?utf-8?B?bHBqUmNCOUlMTDFiZzdObEJsZHB3anl5TFhlZ1ZVTkkzYlB4eWpFUjY5Y0tK?=
 =?utf-8?B?TmN3TEJIVjVmV0gwc3l2em5ZenBLMnZRdTFMQTk0R1NUcDNWVGdtTS9IV2NG?=
 =?utf-8?B?UkdTVzUzczdaSDdZaSt4V3dMdjBtaFpCWlc2Vkl1M3Z2WFJzSDA5N2sxTGox?=
 =?utf-8?B?a2pLcU1qWmZWeTF2dFpTWUVIU1pNWXYzWTQ5bC9NZ1NCN0lHSkQ0MUttbHQ2?=
 =?utf-8?B?TmhMbnpidno3aE9YV1lnVkZyRndYTlovNTY4WnZmY044RldlR1lzb0szcUN2?=
 =?utf-8?B?eGNPRWpuSkt3ajVJeGlORTN3aFN6R09IT29jMVlyU0VnL2ppYlZJMXdEQ3Bi?=
 =?utf-8?B?Wm9FRDFIdG9ObGJpQ2R2ZzZNQmRmd0p3cXc4UE5RZ2g5NWZ2ZEhMNjBtU2lQ?=
 =?utf-8?B?T2dxVEVWTFRFb1ZNTjA0NzZQNE93dG40TG1vMkhTcUVTeVBobGtSdDVrajBC?=
 =?utf-8?B?Rk9pd0JTWDJUR0ZGWndDWmJWd1VCckZ0bTlSelhpL1lwdi9vc2x6QTdMakJn?=
 =?utf-8?B?R2tUUVhuR1VZelRZUFJKdmtMOEladVpNdVZFaFgzU1d0MTF1alpDV3JDQTcx?=
 =?utf-8?B?QXo1eXdodG5iS1YxcW5zNnlTanZFTkZqZGJnSzNmb2ZVRGV0Vnh6Vm94TTVw?=
 =?utf-8?B?L0ZsZXlTR1JGbFlJd2ZkWjNCbVcxcDg5S0FudEFTTVZoTW5mdVY0S1BCcUZs?=
 =?utf-8?B?Vmw0cEx4OVpFYjBVRXJtbzEvYXlOMzFJQjEya0pDWTJEYW5Ld0g1SUprZFlN?=
 =?utf-8?B?TURWMHErb1o2UHVrUjlmTzllakR3RURKalNLYU9HUWZzOUpHL2hkWFcyMEVy?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UU1Nu2y9NHz7Os9eOCkycLo5KbzinViREry9kacZOI5cLY0Z1uOrhjl1JgcasY4TOMO6QZLxG17isFxG2xMUOjMTvo/tayCAwYLpORWULcSn/VbHJKIOYPzoz2fk5fe70yT2dq5D03GIQU6vgeTTfL9XLlZjEsEVL6vmnYiFMccEmYUL5nBqvKJcQCcJxZF2uCNfUtM4ZiMMExtu+d6lJKDUXoSBk3qlVZY2isEQZROmEjJA6UTTHFHjLrK1I5vKcypd1HS+M0r1qS5BK9wfDFU8kTCYW7EwP46m588u2+iPbsnFYhIPLYKYEcouubjAzkcVb0NGrrydEUEiBYkpIk9rWidLY/N+wW5lacbNR0rW5jZ7uYspLtgWKtqAyCOmswoppnAb0WW2WUm/07tQgATC3i7rIQLXFsVnaKZK9T6TcEMxh9Z2Fyu+nMQyTg7izdrDSEmimlSkbWezjknFVHgv2n0aTdwmPU1lOr5ol/fkGnxlWW5l3VpJvQtNZ5VHDfZ9sjcwclyMg/ejMUU5mqEl/yMSIN7gHhdwf3bo/bAxOulRHZpgCNpNHuvdN4lKyAC9IF+Gq2WexrGjW6Dn+FjXS2QhCSlrf+ABwRSsP5ahQWBQrZzJSfICWL3ix77LH73wGcu2POM0ltH8aFrkxlL/pHEXzZFFnqjFKkcRvkIuykPQVBz3a4IxKldN8baxc14eFl++/B5s1HkTtr8dQY8gZ35BNBFX+P44jY0V5L1y6UaotG1YNp+BlbHTCFgWR+5okpc9gZl1nn3n/FBid81OXf2VOdvkf9a5yqlsjD5Sri+4b7KHBJU6oBAzz6q2GSbJKIFT/1ofnXEC3gQqopbteUAJvBqzV/sUqHeRMthKLj0fxXkK64lbwy4eOVoAVgnwqcAuNc9UudcUsA5GXg==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883d9ed5-a640-4da9-b7cf-08db9991d4f1
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3618.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:06:22.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhjNVPuNfOYX1N6IOu7COdA7JRK/Rdutiufyl5IuNt0NPh+ei7AiQJEi+SI9qMJuuvHf5RB4Nq88Bc6x2GVGIeUFVBkxE/8FWGuxIp1kMC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6908
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 3:22 pm, Peter Zijlstra wrote:
> On Wed, Aug 09, 2023 at 10:20:31AM -0400, Josh Poimboeuf wrote:
>> On Wed, Aug 09, 2023 at 09:12:30AM +0200, Peter Zijlstra wrote:
>>> +++ b/tools/objtool/check.c
>>> @@ -455,7 +455,12 @@ static int decode_instructions(struct ob
>>>  				return -1;
>>>  			}
>>>  
>>> -			if (func->return_thunk || !strcmp(func->name, "srso_safe_ret") || func->alias != func)
>>> +			/*
>>> +			 * Both zen_return_thunk() and srso_safe_ret() are embedded inside
>>> +			 * another instruction and objtool doesn't grok that. Skip validating them.
>>> +			 */
>>> +			if (!strcmp(func->name, "zen_return_thunk") ||
>>> +			    !strcmp(func->name, "srso_safe_ret") || func->alias != func)
>> Hm, speaking of renaming they should probably be called
>> retbleed_return_thunk() and srso_return_thunk().
> Yes, clearly naming is better in daylight. Let me regex that.

btc_*, not retbleed_*.

That way it matches the terminology you'll find in the AMD whitepaper
about what's going on, and there's already an entirely different issue
called Retbleed.

~Andrew
