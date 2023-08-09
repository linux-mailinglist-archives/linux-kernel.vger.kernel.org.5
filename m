Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB5776286
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjHIObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjHIObd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:31:33 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A310F5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691591493;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AtrcJ0dTneACcTTUBnrjC4GmQ3e9hQULVL+JkdhQyHI=;
  b=gPoemyYgnLTfdWVAcq9/XxcykNozaEq/PPBDMVvgQRE9+YkFrIbReLHL
   GC6zDrHaYbHqH8G2w26KzbIklSsfsq0b3+HPrJPfuilbO0qBgzkRRwpgV
   Y+VSylJVhqYEce0gV23ShgWWRt6bQ1SAP7XalNIuGLoUtlQndECCx2Kmg
   I=;
X-IronPort-RemoteIP: 104.47.58.107
X-IronPort-MID: 118878916
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:Oy5lo6KfBns5gYW1FE+RIJQlxSXFcZb7ZxGr2PjKsXjdYENS0zdSm
 mQWW2/QM6qLYDH2L9F/bdu+9U0GuZTXy4cwSFRlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrawP9TlK6q4mhA7gRvPaojUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5FC2Mer
 uUpJQoXbw3fq+vs8L+cTLVF05FLwMnDZOvzu1lG5BSAVbMKZM6GRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/dnpTGLk2Sd05C0WDbRUvWMSd9YgQCzo
 WXe8n6iKhobKMae2XyO9XfEaurnxHqrCN1CReTmnhJsqHTLx2MeJS89bHvlrMfornKbR/4Cc
 2VBr0LCqoB3riRHVOLVXQW/oXuOuRM0WNdKFeA+rgaXxcL8+wuFC3IWZj9HZsYvuMI/SXotz
 FDht8O5WxRsvaeTRHbb8a2bxRu2OC4IPSoBaDUCQA8t/dbuuscwgwjJQ9IlF7S65vXZEC/xz
 3appTA6jrM7hMsHka68+DjvjCihqZvJZgo04BjHUGW46A9weI+iYcqv81ez0BpbBIOQT13Es
 H1ancGbtbgKFcvUzHPLR/gRFra04frDKCfbnVNkA5gm8XKq5mKneodTpjp5IS+FL/o5RNMgW
 2eL0Ss52XOZFCLCgXNfC25pN/kX8A==
IronPort-HdrOrdr: A9a23:NItEMKGoT6yxolr3pLqE1seALOsnbusQ8zAXPiFKOGVom6mj/f
 xG88506faFsl0ssU8b+exoR5PwJk80maQZ3WBTB8bAYOHe0FHYTr2KlLGSpgEIQheOktK1tp
 0QFZSWdueQMbESt6+T3ODSKbkdKbe8nJyVuQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AsJAypmt/2Yf4vCWm+4Y3YVCd6IsXeH+Nl27hLnW?=
 =?us-ascii?q?iCHs1ZLTPeVK3/v9Nxp8=3D?=
X-Talos-MUID: 9a23:P9ueDQXP7djPOOLq/Ba0hT5vGfVD2oTwBX5ctakjp+XZbQUlbg==
X-IronPort-AV: E=Sophos;i="6.01,159,1684814400"; 
   d="scan'208";a="118878916"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2023 10:31:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh34eRzdvlIqBBcM/C1NcQT2qJg4bSq9zknhyZbzxQL941bstLjOKVIRENM0lMEd3oW5te0KgXFtPjOqvlsc1K5Tp5UyA9w+rZmEMmH4ObotIqKAA+3gnRKF1fMXV8eqpD0pTnTvSL7jvqd1aXex3REuS8h1e9SZg/WQ3bDv9Fn/OU2CIMI8CYbcAxku1vZkJEeGlNCpunwODGz3nTWVYptQYJgh8wu1ZYRlLf3tLHRaOmAbJhmwFUWedA0XH0+jVCY4dlvNf3LOZRRRjUcLsJFFhvm7+BMesPiU82O1ONXp1xkLgx+dXOnitxoqHzapq++uftcpO2Ewf7wog0cD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSfpDFxqF/NgWoSRAswsCUNzpcYxxyLb8ppHDU+M67Y=;
 b=TrhGOhDB85W3m0HY/c/0o22t+TYGMJP8EgrpPY0f0Mh5G1UI915pRdJfIeoeRtVWHq0E4sqWjQ7E+TF4kslR6mTZwkNtbh42iAGTw92G5k/bK4iv51LdmBbEZcFo34HUNZQP66Cdw1G8EGCa26HgLZWvg5GWUMBiKsb4NOmEUoPQ0bLxRA1dVi0CgxSpva2skt+nPMl15JH8DP9HAfgTMcUuNZQ4fcVpBQYnSlTuF4vdZ+fc88zPw1cVs5qiE4LanO7XAme6YqpNVlZMX+CL76GJJHskLTma7vIY4j5TJYJydVZC6ucTTYMfBp9hf6t/zOLTdoHA8bhzz7XJNb0upQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSfpDFxqF/NgWoSRAswsCUNzpcYxxyLb8ppHDU+M67Y=;
 b=mgWYEZej/2Sz+9plOWbqLyHMLHXXtgfpCdcJO14AsyLE9KLubO/dZi2FIhtqHMZXzW/zCqMFNSQqSYvO0Xf2L6lksvCf/J5W0KjWDvrD+xE3KgYu2CRrtbLfvAD+a+Ej61WKKw4WjQ+SyBAVKho2aeNfe24UW6XbqVycJV8fB6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BY5PR03MB4919.namprd03.prod.outlook.com (2603:10b6:a03:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:31:26 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:31:26 +0000
Message-ID: <0ff5cabb-835f-2183-c8a5-5308e23e7f6f@citrix.com>
Date:   Wed, 9 Aug 2023 15:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew.Cooper3@citrix.com
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Content-Language: en-GB
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230809134233.d7hlutglk2j3f4w3@treble>
In-Reply-To: <20230809134233.d7hlutglk2j3f4w3@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0622.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::7) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|BY5PR03MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: b5540fd2-3438-4039-9ee6-08db98e54fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qahxx5ynpclXWVpDUTkNa6SA+1DOto+mb2QSmxQz/ixfN4cBnKozCFBSA2I7NlZ3FhyIbg3N1WOmUGiy8LO1EAi7TsJPfzRzIf11MxBuyscZAUOV5oG0Yfq5w6s9BZ53KMa8BOBhB2EATlLKPvAcDoRKtsgkWN3YoOlNqUPbFVv6gzmsCDX7ILO0RZDN01G6VNJpTBXAhGqdj0WoPLxDTg1UzQalPJIisZC+Q3unQN0KbZcpUzA8LtC5fjxdNIMGLCkXlo55CB1r7Vs1zTcQFjFLXrMa4Glp7+7tpLqhVjHH9QhDpyyNyYI7HMF4aFEP7g9eWqgPOCumkYQviKH0SDwpu68PLzokIJFyuQBs5NCf8dQX4upgb7idw7TIu+qoHfQ4bnLAdNVnIREqh2lEwquHuppF6zL/KBckZPBZDNbRuJxau9kWPyVb3rGjhmSnLuIIX2E933abY+lhiz53D8LwxHVXZb4Ug0D/t4FRwGnW0rX6xQNSCxpnz4h4M0OuszGFCnPOGMo4ciIm7KZioJxo8zSBlmHwhp+Y7VFraAbSC7KaPsXZe2FGnD6ZyereUP2kJsVjb5gKA162kbW82tgdVixkYQSCw8kJcxY3K0V/gujQ4tduUmdcsgJrgaCl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(186006)(1800799006)(451199021)(31686004)(83380400001)(478600001)(82960400001)(2616005)(9686003)(6512007)(26005)(53546011)(6506007)(8936002)(41300700001)(66556008)(66476007)(66946007)(316002)(8676002)(31696002)(4326008)(2906002)(6486002)(6666004)(36756003)(110136005)(38100700002)(86362001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTc0WXVnMlBvU3pFVzNPQTFobk0zMm1pZ1IxTlRGSTloSGpWN0hPbUNUMXFa?=
 =?utf-8?B?NUh0aFNaWEZTNHNzZTNtV1dNWXA4R0xSVFlaTFdjYWl2UUxRcEFGYnV1UnB2?=
 =?utf-8?B?ZUhjSysyeUNBeWhoVUNOUG5rSWtJazY3Q2JuTFF0VTdLdUFBK3hFcHlyNCtH?=
 =?utf-8?B?NzBpSnowV0NIL0lod21WbndIUjV0Q0NIN2tSMjFuK3BkUmsxYzhEYzVGY0tJ?=
 =?utf-8?B?c3N1OTBmV1Y0Q3A3VCtqNTZPWjNJeTR3aDhQcWxucmE3L2Myd2NxYkVQOWRW?=
 =?utf-8?B?UE5vdUY4clRwdGdyN0p2enpWTG9tKzhoUUxaT3NHay9kY3p6SnZqTU5saXdL?=
 =?utf-8?B?dndKV0E4VUcwVE4wUktPL1lkMnhSMDAvRjRhdGF1ZXZHL3J0eVpZMzBLYVJ3?=
 =?utf-8?B?QVlKanpvRG9PRVhRcWNyTmllc1V1UUIzUUVLYjlSLzhTOFhTUGRwV1V3OVhU?=
 =?utf-8?B?bTh3ZXhqK1hlcHhheFVvVlV0ZE42NmM0MGUwR0ZxUFZjVlpoRmFRTFdNSk5K?=
 =?utf-8?B?cHdMSERSVWZnbFc3YWtVYkZqMDlJMzhPcWlORnM4SWEwckJBMGFTVmd5c1Ru?=
 =?utf-8?B?WVJmdEQxRUxNRFk3RWZ0eDlUTHBwQlNYSTdsSzE4eUJyYlUxeFE0bVZuVFF3?=
 =?utf-8?B?eTB1cUtXbmVMU1k4MmRIdjVuWVBQV0dUdVpTcWl6clZLM1hQbkZiak1pY1J0?=
 =?utf-8?B?TGNpNjZDRGpXVElvbldsYmk1MjVxZml6TFdHTmRtaVN0dzJFM2J0Yzd3YVEr?=
 =?utf-8?B?TzdxZis2UDA1MWlBWVVvaE1aSFZRMFkzVmJQUzMxNTlpUlN2eml4Q0cwS2lO?=
 =?utf-8?B?WkNSOEpSWkpWNGlGUlBSMWVjZ2JVTzhtSEZkclR4aHpGZEtUd0RDTXVSeUth?=
 =?utf-8?B?SUJZOVUxelpGMnp2ZkdtSmtLV3IzcEhFQm03L0VVRFdNMUU4bnVseEphNnZ4?=
 =?utf-8?B?RUVrdTdkNTdPclJqaXpZZncvZEtEWW11YUlZZjk0dmFhTmpnSnFwVlFyd1Vz?=
 =?utf-8?B?Nm5UcVBmckZ6TUdscDRGZ0xiMWtoY1h1TmlqamdiNG8wN0ZMbHdjeE0vR0s5?=
 =?utf-8?B?Zkw3Rk82YzlqSkU2cjgzRTB1Y25wSnRkTWxwY1lLelltdzh5YjhkVDhNclUx?=
 =?utf-8?B?Tm5pUU83bFhiRG5WYUJrMXViZHFVS0RKUUo4YjBXNktLWFFNSGc0WTI0LzlD?=
 =?utf-8?B?dEc2Y1hyL0VqbE94amYxMEJBemFIMnhrNWJNdmlwMXd6cWVTOXF2NnFPTUNS?=
 =?utf-8?B?QUhkNndrNXFYUmRvTitOc0hFNk1ncXcxRnNOd1BiU1U3Y0FKUldWU2krQ3ky?=
 =?utf-8?B?RXRwT1h2R050anRZcFAydDhOeG1HRlR4T2FnTm1QeTIwQmh1ZmpURVJKMWs3?=
 =?utf-8?B?RXdUR1loU25RYUJtWkJhZ1F3b000YUdqWktIemgvZjFjWmtNamdJSFRsMm5R?=
 =?utf-8?B?N2dZN3Y5Qm9heVJLaWp2d0V5enBLOUd0bHczV0dSNnh5RkpBUTJ4VW1HaVpR?=
 =?utf-8?B?SlVWNVBEaWo3RVhJSjlOOXpVV3ZlZHNoa2ZvWjJMMERZRjhmUERPRmt5cit2?=
 =?utf-8?B?cUlicGw4ZUY1OTBLZ3lMdkpmMGVBRGE0K2I1aTVEN29LZHBRVFNvYjFMcTJM?=
 =?utf-8?B?c1hzVG9SWUs5WXhoQlRYenFadk5haHBNMkRSN25ZSXNzVW9LdTZKaFkveS9C?=
 =?utf-8?B?VVI0cG5RV3RaNlIxR3pyU0pmakxwVU5EWGhjSnIzYnNlTVo2SVhyaUUrS1NN?=
 =?utf-8?B?TStrOWx5NWp0a0FnNGlOdWFGWEJZVlFZNmhoOEdteitwVTZ5RG93akVSMXRz?=
 =?utf-8?B?aDVBa05Qc1RCSGczcExUYWJkYUZVbWFFanVNUFFBU2dOWTNJM3VtNTFXbHl2?=
 =?utf-8?B?bmZNK091RW5lRVQyZjQ0djd3S1N2ZW90dDNPMExPeUxzakROQ2ZrNkRFaEZQ?=
 =?utf-8?B?cnhLTlV0TkY0cWNZNllpa1hnZ2dQbFpyaHVLMlNwbVlOVTVXbGh2RGl6SGo4?=
 =?utf-8?B?Z09yaUpveWJLejduaFZTdkx2cHpNdjdOTGNSNDhxZDZqNzVlLzB0ak5ydDgr?=
 =?utf-8?B?WDJ1SW5PMnphWVg1d3FMQkxIMnYyaGdJdDBYVGUyS2NXSXJzTi9FbEVLbkcz?=
 =?utf-8?B?Wk50MG5qeW9VNHdVdUJob0ZMMk4yNGdYZ3plTGtNQVE1aXVyYXFkVHY3Mld6?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X73lF8+TVarI+O3piuIWehQlhHzUnjvqTgkxo0zB6r10+1Ne4BWEWbkFZhs7VUmU1YRcGD2lkf/2gYcYcN7biVOWxy23evOD1AUlYCPjti5pV3wwGA2ALZOKD9RcZmDu3TaG4p3FlItG8qw7xlDEAgFiYdbridZljRR9vF02YRtuvr8P3VFAn8U0XziiLJlWhgDaECGtNUIL9Ql4Pw7XlEKVHaxkVZJ3GE8Xl+c3/RPuB7qSuKcAcXat/8FzVvl8pbwUKJp7hCwEGc0fzQTfauzitdklqzCc5j4DNo2WRgNRohKOEUkkKUfpnequjFVT7hLr6ncm+PaNYyCd5WTU6Vg+hPovRODvCczJAMDI4OLVAuh4bEjvps/3rtv0Jcr9hR1MqOnohzjois5cgDy+CPSd8kVXiZ9U470yXB78j+EqjR+Wow0Dlz5oYXcBRIQx/h/2rlpmApvFe5p4USNHI3VJCkQG2aerl7xChPXrpVihhjbazg2OGVxwVviyHIUQPSMgVV4tLOlwsLXFPMJy4gbtHRCMoFl0mMYJvfAeWrKkZtjuWi1aU1td5eLqXH6Gvd8ZqTTcHZZOn3TjdTFkmMxDebcTpXjavIhDmgzvYrBwDvN8JTNwIGLlSSR5z17Ta2jeQDqGcfMZuZn0kAl1+SGzP73cO53UeRe26X0p//LoBCamubctoZoMDO6zTRhGNMSQAWOXkFSSwkBBuM3i5O8QARWEx5kAYSF1WG0dLB4ma2wg7U7bHEa0VerQkYFm/6WDffhMGQpMYO3JJxT1Gor4KO9ZpNaX/vGzKeyvGHkuV6NbsLeyvsfXsoY2HyaUcc06sDvQ+/7Nds8h5x9NbhOtwhJR4Q+3qkcaGpZuo1HMkAQBNZkwHiz6k3RjNvloznuJt2+qSrx13IrfKByUiw==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5540fd2-3438-4039-9ee6-08db98e54fe5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:31:26.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URPo+HCXQY01DMGFk6UCJYCKJEepOFvYt6IyCaCcuaqmq3z9FZUwdDcPZPNBrre1S8a/laj0g9od0M1EZrNCdU80Ep+EfUPnarig3a3aiUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4919
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 2:42 pm, Josh Poimboeuf wrote:
> On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
>> +	if (boot_cpu_has_bug(X86_BUG_SRSO)) {
>> +		has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
>> +		if (!has_microcode) {
>> +			pr_warn("IBPB-extending microcode not applied!\n");
>> +			pr_warn(RETBLEED_SRSO_NOTICE);
>> +		} else {
>> +			/*
>> +			 * Enable the synthetic (even if in a real CPUID leaf)
>> +			 * flags for guests.
>> +			 */
>> +			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
>> +			setup_force_cpu_cap(X86_FEATURE_SBPB);
>> +
>> +			/*
>> +			 * Zen1/2 with SMT off aren't vulnerable after the right
>> +			 * IBPB microcode has been applied.
>> +			 */
>> +			if ((boot_cpu_data.x86 < 0x19) &&
>> +			    (cpu_smt_control == CPU_SMT_DISABLED))
>> +				setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
> The rumor I heard was that SMT had to be disabled specifically by BIOS
> for this condition to be true.  Can somebody from AMD confirm?

It's Complicated.

On Zen1/2, uarch constraints mitigate SRSO when the core is in 1T mode,
where such an attack would succeed in 2T mode.  Specifically, it is
believed that the SRSO infinite-call-loop can poison more than 16
RSB/RAS/RAP entries, but can't poison 32 entries.

The RSB dynamically repartitions depending on the idleness of the
sibling.  Therefore, offlining/parking the siblings should make you
safe.  (Assuming you can handwave away the NMI hitting the parked thread
case as outside of an attackers control.)


In Xen, I decided that synthesizing SRSO_NO was only safe when SMT was
disabled by firmware, because that's the only case where it can't cease
being true later by admin action.

If it were just Xen's safety that mattered here it might be ok to allow
the OS SMT=0 cases, but this bit needs to get into guests, you can't
credibly tell the guest SRSO_NO and then make it unsafe at a later point.

~Andrew
