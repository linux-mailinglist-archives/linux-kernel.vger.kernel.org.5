Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0FE77603C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHINK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjHINKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:10:54 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C191FF9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691586652;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C+mlNS/MxHcxwCLdkvPIbjiWaD4ONFP7/8bzK3kClJw=;
  b=OTXqSakmfJjqaRdnPuT28kuxW/dopnqJmWeQrYbd+Um/G9Zle/2le2A7
   IcoDa9nqpsUOXnBY6KC64PHpMCvkfRP1JgCn6RQKa21Ud5ziVm4oR5yEt
   YgHmcZCfvMcqUzHSR4fvB1RiyWi40DM/2jpWn8uj1LMEjupaHnZ31GW52
   Q=;
X-IronPort-RemoteIP: 104.47.57.40
X-IronPort-MID: 119007454
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:cgYSvK4pOwNKhJjgARAIUAxRtKbGchMFZxGqfqrLsTDasY5as4F+v
 jNNCmqAP/yOamv8LdsjaorjphtV75bRytdqHFFk+Sw0Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9lU35ZwehBtC5gZlPaAT7QeE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m2
 dE3EywIPky5h7jpwZGwVbJo2uMaFZy+VG8fkikIITDxK98DGcqGeIOToNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6Ok0otiNABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTAdtDTOXnqqM26LGV7jA6Gi0yFkCDmtn6s0S3dvxGM
 FxF6xN7+MDe82TuFLERRSaQuHOYswQOc9tWHfcz5AyExuzT+QnxLnhUEBZCZcYguctwQiYlv
 neNntX0FXlsvaeTRHa16LiZt3WxNDITIGtEYjULJSMp6sfirMcQhwrLR9BLGau5yNbyHFnYw
 SiNrS00gLg7jsMR0ai/u1fdjFqEqYLEQQ01zgHWWH+14ARkYoKse42v7x7c9/koBJ2UR1+Dt
 1ALnM+R6O1IBpaI/ASVSuILDrCv5t6fPTHciEIpFJ4knwlB4FamdIFUpSp4fUFgN55efSezO
 BOL/wRM+JVUIX2mK7dtZJ68ANgryq6mEsn5UvfTbZxFZZ0ZmBK7wRyCrHW4hwjF+HXAW4llU
 XtHWa5A1UonNJk=
IronPort-HdrOrdr: A9a23:McvAW6NQx4DHFcBcTy3155DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jztSWatN/eYgBHpTnyAtjlfZq6z+8J3WBxB8bZYOCCggeVxe5ZnOjfKlHbalXDH6tmpN
 xdmstFeaPN5DpB7foSiTPQe7hA/DDEytHQuQ639QYTcegAUdAE0+4WMHf9LqQ7fnglOXJvf6
 Dsmvav6gDQD0g/X4CePD0oTuLDr9rEmNbPZgMHPQcu7E2rgSmz4LD3PhCE1lNGOgk/iYsKwC
 zgqUjU96+ju/a0xlv10HLS1Y1fnJ/ExsFYDMKBp8AJInHHixquZq5mR7qe1QpF6d2H2RIPqp
 3hsh0gN8N85zf4eXy0mwLk303a3DMn+xbZuCqlqEqmhfa8aCMxCsJHi44cWADe8VAcsNZ117
 8O936FtrJMZCmw0BjV1pztbVVHh0C0qX0tnao4lHpES7YTb7dXsMg24F5VKpEdByj3gbpXXd
 WGNPusqsq+TGnqLkww5gJUsZyRtzUIb127q3E5y4OoO2M8pgE786MarPZv7EvouqhNCaWs3N
 60QZiApIs+P/P+UpgNdNvpYfHHflAlEii8R156Z26XX506Bw==
X-Talos-CUID: 9a23:ERkiOm8yUWpMhj6J3JqVv2I5Nfs5dy2B9neKfE6bAnkyTOGycGbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A7wJn7wz0Q+qgvgtaBpBUrD63+FKaqPiHGnAp0o4?=
 =?us-ascii?q?+gOnHDCZ5FhmElyTmU7Zyfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.01,159,1684814400"; 
   d="scan'208";a="119007454"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2023 09:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krp/AGBM+zXYiO+v9ft2Sb2F67Aaytasdjh9PQJCK0u9fPFGFbSkJqSoBiFWG8Vmr1P5W1zc+0LSF7Y+1N7nh6b/XkoL2VIFJ/4jgV703wtU2pXbEL1GbbaoKTp15MkFU9zEGXje4VyXV7Jdtn3/5sDL4AQXQsO0KqbVDY9aCBXEYWNI4ObyOX9cMDnRHgVpfqv7J16U0kAc8Dh4UhuhnQTlRLW5c7GSHb08GvlerxUHm0kBAgqOHWqNxq943LcAW1piB9iEY/cMNBybqu9hCF2DszIQ/pMXk8mgsIZuxO+CQekkTYcsHyTI3aVS0MkwE5/muXMg+5WAvnd3Y4Rr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpIJWoN+5lBK9p5G6mxsPWhfZqRrm9wBFceoOIP/Wvs=;
 b=G3skk37eCPIGOpfeyVpdWgoyFIeUYPNNJ3f+QPBAZzpswUXm0b7TcuBmpIoPWEIsF6RA5Qp6rrkU8GViJAQY+7Z77ianvDcuo2Fv9hWTBKfnw1fQpGNbmtv4w606W5wAzByL8XWl8KPuFiRIN/EoLmKlgcXqFyVwUghoxX9v7b9XmWxeTfocBNLH0TYi1U1IoJMN7Azy7hmR/Wx4nIbDeDJ2rbTpGqfCTNhJaV0e8BNEGzeS3IBzlutF8MGr+uRbuPwRSgRcmDvuKQLxxxlH9085X5R9OSC7hmIorw2dPr1NQj3H1a7mQFATLyxRxzUhm8IEhAbegc+eRSzDnNEYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpIJWoN+5lBK9p5G6mxsPWhfZqRrm9wBFceoOIP/Wvs=;
 b=cQ/yrdHwacVlZN7UtR78CiJspk/wEmHUaX0sxh4W6HJ+jYbe90IQ3BGG0CljdANReybKz/KU0IUfguhJW8IGwmeZMZS9p4pb0XusXF3tZck49P4OyHOudsV28i4H/rrimxICTtAKE5U0S7dEL5rgUrAIBHpc1xaxxAJiWJQZ1eE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB5504.namprd03.prod.outlook.com (2603:10b6:a03:28a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 13:10:49 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 13:10:49 +0000
Message-ID: <64f94037-d370-aa83-f8d8-ae827f606f60@citrix.com>
Date:   Wed, 9 Aug 2023 14:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew.Cooper3@citrix.com
Subject: Re: [RFC][PATCH 11/17] x86/cpu: Remove all SRSO interface nonsense
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.192502969@infradead.org>
In-Reply-To: <20230809072201.192502969@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::10) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SJ0PR03MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: c4853415-0099-45e9-f1b7-08db98da0c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1pie9LD/ko3RZDRqMlreWOQQD8/0CyDvqPXIn2c82nPN25p64rc1LjqsidbEs7RJhpK8rl8ySkGFV+WtV7KoAHfLWRsndq6MQit8h8qsbDinO7dvG7oLSUPIKwKTs1A0yRv8/b94ymVRpoyCIOUX+ILfaUElRsW7GgwUENoskjEnxCAprl9SKieF68MloJmEqJ+m1GQNm4UepI2ayILeYt5sEFt0jbQYNu7iBADgK7HQkqjkE9N75R0FfKIkGlmLyuVIWJodxr1fE2XGLN5dvGGZ46bLxFZcROdMKytfoOuqQmBt/5iLhY2iqkMdqktGldkSWEr1ono7F49ZQmlI4qkhZJxD1/cPv6aT7zkAcBNa/KAmE02Lj9Z7joYR7e68YaSF8mqZ7II+Yfl35YFzmLyT9BOnayxJOO1vc31NjoAJn5ofznJAHhgAJQjlAGaQxAqfmEZcDCKeg0j3Mx/3MvvfCO8d68kOnzrAActd1d4qWUDQjMkql2nuHF5vhlJcAgsyw/LSA6HPCUirdLB1siyxAJwbA799BuPrrX+nnFmFtsBHJaDz3SMwwB9sVoIbGtFmCn0OphEqC6orrtAxy12zAoIOnz57lAPfivZqmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(186006)(1800799006)(451199021)(2616005)(6506007)(26005)(6486002)(36756003)(53546011)(6512007)(9686003)(966005)(6666004)(82960400001)(478600001)(38100700002)(31686004)(54906003)(66476007)(66946007)(66556008)(4326008)(41300700001)(316002)(5660300002)(8676002)(8936002)(2906002)(83380400001)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2dFTWJJMjFvNjVYZGhXTDRnSlB4REtWZjZkZ292dlV1UXp3RlZOMHlKcXdQ?=
 =?utf-8?B?UEJlbkJNR0tjSVUrWnlvaEhiL1VjSTkrb0Q1SFZOb08yVzRwTW45MVRQMHJu?=
 =?utf-8?B?dHc5MEFtRUFBcC9DYWx5RSt1VGxlSDVVSEx4NjB0ZlBzNzFmQUxmczM1TVc4?=
 =?utf-8?B?RGRCUFZmcmJkcWhTOFdwTk9vcERMV2dSQWxXTHl4NlpxTXcwN1A0ZCtzWDFP?=
 =?utf-8?B?Z0h2dUJPSzFoVXc1eHlpMXF2YjZWMm1KdkhUbzRtZkpDZGJiM2Q0VTBtMEJs?=
 =?utf-8?B?ZVJzQnZDMDNWSkU4aEJKMkFVTVk3K2tuOG5tanN2SGdhTUdMWVBuRXppVENZ?=
 =?utf-8?B?cFlXTDRjSHFhQ2ZuL0NZSGx0cW1kc0k5aHZQU2Q5YnBRUlVkL0E5V04vUkNm?=
 =?utf-8?B?SU4rU1RjVlRKY3Mra0phWm9KK0xrc2YyRWVOaFZyQzV2UUtoMm1UbXdRSS9V?=
 =?utf-8?B?bU5LSzAwNUkwVGtrWEltZjBTVnMwN3YwNTk3UGc4UFVhRmlnKzVlV0o4WEFP?=
 =?utf-8?B?d2FFZWtDSWNiZ2JnKzlqSklnR3poSTNpblJDOU9tRkhFUzhVWEVoT1E5WWhH?=
 =?utf-8?B?SHpLaFdyMm9UMzhWdXhjOXIwS3RUZ0tKdW5kekpjWkQ0bW1NVDBoYTkzSjQz?=
 =?utf-8?B?QW0rQk1ERU02emw1RnVoV3YxRVV3ZzRZRE1GYkdFczJ0WTBYMDExbmZ4bmFC?=
 =?utf-8?B?MStNa0JqR08vQmN5dUVDWDVVMWJhOEhtWVRuWXYxS1c1eDdTejFxY1AyOXVa?=
 =?utf-8?B?OUhkdjlKVDRFa3NTYkwzUmFuVGlVS0pCUCs2VlJxZ05VdE40aXVoRG9NZm5L?=
 =?utf-8?B?M2pEZkQzSW5aWmNYVTVONExkaW5ta0dUK09kSjg5c3cweTNiQ05NRGU3cTN4?=
 =?utf-8?B?bEwyV1hPa3o2R05DZEFQS082bFpmSWZUV2NodE5DMFZiTU0weGNhVEZJZTJ2?=
 =?utf-8?B?Y3lCRElEMDdaSmVUcDRmWm9PUys5Nm9IeUx1QTNCcDNHZCtKUXRidExBUENB?=
 =?utf-8?B?aFNiRXg5L25uWjJmTXk5WnNGcUg0QU9wbG1sUCtsN0JGRVFBL0xBd0lnVWtV?=
 =?utf-8?B?Rnc3c1JXNTZBbDFlc0pqOVhsNG1tNjBFLzB3R2tKTGJWVk03T1FCTDFnVFZQ?=
 =?utf-8?B?NVJpcURNMlFiZEtLNUg3WFpxNk5BdWJSY2Z0ZnhUait0M2t6T0VnTGRGY2I0?=
 =?utf-8?B?aGFQUnl0YUpBZzZlL1RiZlFYM1dCVzFjVVdNWTU1eUJjKzdHL1FJRTBVVVp4?=
 =?utf-8?B?R3NZZkFRNnBHZWlrMXZ4V3FXSmpqQkRHZU5KUXV4Sk9iOFpVdlFsL2hDNVlT?=
 =?utf-8?B?RDVOT0NlaVdRTndka1ZBZm5obE1VWHdHZk0zcDhnWis2cTQvQ2RnTG03anBj?=
 =?utf-8?B?L0dCS3paRjZMMmE5aTUzYlhtcktLSkZXemdkU0V5NHkrSytPMnE4Zis5Z21S?=
 =?utf-8?B?NU5KSE5SU2ViTE9wTlB0Wml0UlZaUS9meFdmWVpWT1h1M1dJdmtOalMvemht?=
 =?utf-8?B?Mm9WejhVSU9WM2o0RjJRY2JPbmdrdHhUNFp1Nlp6eEpYeURNeXh0eEptczFJ?=
 =?utf-8?B?eEhydmxQelhnRDh2MlI3UGhPMkZld0NDUXNuSW9zT3RKK3B1M0RUOCswUTlY?=
 =?utf-8?B?Y00xb1djUlhSQkRpQ0JEUzhzQTFQWGNaSldla3VwdnFUV1RWdEd4ZFZDTDhR?=
 =?utf-8?B?cUlhUDJCVTE5UUtUSE5rTHhQdlVpZk9hR3ZPT3p4b3o2Ukk2RUZZTm1FUDZ1?=
 =?utf-8?B?andHWjEwU1NvUERveXYzM0RxQnhDN2xWcFIybFBtU0lNRzNJTnZVcmUxdTlV?=
 =?utf-8?B?Y0hhV2dLeGFvTEdDY2I1OU5EMkRoeEljMXdEM0Q2eGZ6ZFJQdm5iRVBEMFRM?=
 =?utf-8?B?a3VaNDRZcXQwOG9LQ29MNkFpY0M0d3hmbkw4aDRGQlRSRzFjZHBuQmV6NnQ2?=
 =?utf-8?B?U1FqQXBFSG5rcTdyeG8renhUeFNXN25LbGllWCtXUXhvZjFiUlBDWlpaeS9U?=
 =?utf-8?B?R3hJcjhlZUZVenNFWXY0WmJ5SWQyd2pBWVFGVnVmOGxDQ3l6T1BVcmt4Tkg1?=
 =?utf-8?B?bm9nM0h5M1QzUFJHOCtrVlZQQmVUa0orZHRTSXV1MGRtSlp3aDVSamRSMzVl?=
 =?utf-8?B?cm9GYWFyc2d1K3F5MzVBaUdQUm5Ja3hCV29xR2ZMd2REN3dueUFBT3IrRDMx?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R2JOSXhrNDFIWG83V2ZnTGZzU0NPMFVTbEpKbmFybVQ0ckF3dEFYZllwbzFv?=
 =?utf-8?B?RjIvbjJIc2V0UVRxeVRMRHBDVVNXdGJkNkVQN2Y4bkNLZ0VPeUNrUkFLbmIv?=
 =?utf-8?B?REEzSmc5N1EvZ2V4amJ1Szd4disrdnBQdDJGc2gzVmcyMWU1d0tid0N1dGFL?=
 =?utf-8?B?VStIWThuL2xwYW9HU3N3b3h2SlVFQkFPY2FiL2xMa3ZPNlJkQ2VDTWtLWjJp?=
 =?utf-8?B?UnNHdVZoYTBvcmU5V25MWHVTMHgzQTZyS1djU3cxTXpiQmUvTWRuN1JTVXEy?=
 =?utf-8?B?KzZHTzJ5SkNsYlc1aW9wV0E5TCs5aFNZbk4weTlzOVBxamQwaGJRYndjMmsx?=
 =?utf-8?B?UXBlZ0hoRnN3MWdqa3ZvYkt1dGFjYWFzR3hsemlmK0tCSVd6VEpyMWc0bHJa?=
 =?utf-8?B?N05pcVY4VlQxUzBSeTFGZzVLTEoyMHFqTUtiQVZQbEk1U25uUkRHRGFrWjJp?=
 =?utf-8?B?cytOSUZSbWRlMzlWbVJ0UlVvWDhQZ2Q5ZENpSUhEaTEzWXhRSWFXVzBoYVJL?=
 =?utf-8?B?R0xQaVEyN0RhM2VWeVgxeXVWanhNNSthMXpRT1VKcS9GZTZKTHo4cVduZTl5?=
 =?utf-8?B?TW1JSUptNW9CVFpHRkJwYVpaZ2xCYXNub1lXK2JrWGppMHRWbjlLNHZsSExj?=
 =?utf-8?B?RFYrSDRHSXdrQVRIUnBScG9xM1l0anZMb3RHaGhNYitKT25jbGExRVg2N3pR?=
 =?utf-8?B?QzZidUQrK2Jpa2FpYlAzTUZNZW5TOFpjQnA4M0FKd3RIaEZ0aE9xQmkrcml4?=
 =?utf-8?B?R2tGOFN5R29QeTkwcjgvelFYb2lCbkk4ckN3cjRLalUxVU9EdVpmWG41Mmpl?=
 =?utf-8?B?dnJoSEYwSUliRnMyTGoyTnkzZHZ6MmhRTDFOWkR6ZWZublkxVC9UZVpzczdJ?=
 =?utf-8?B?K1gwZmo0aWVIeEJEOC90TVl3OU1TU2tvNGR0aVR4Nm1rSFMvaHZPNDA3Z2M5?=
 =?utf-8?B?RG5tSlJtb3g4ZERlV2hicm5KeDVYQlorTzJUUlJBdmtBKzdFV2FwUDFOczdE?=
 =?utf-8?B?N3VxZW05R3BYcmNyRG1oa01kYUl6cHl5eDlValNIang4bTVrTU9ZNGVhdFN1?=
 =?utf-8?B?M1dkbXZqa1ZCeEJuS0VMV1hOTFFQRVJ2R0pJck8rTjhDY1RkUFR4SEJzZnFY?=
 =?utf-8?B?QlRYR2tjTFptRC9tOVVaUUYyWUhValVpcGJtSDNzN2dXNkVEcGVma1prVXJk?=
 =?utf-8?B?WVV5MFlhU24wbGQwdE91TE5sSEJtWVk4TmtWMGo2bXZKRzhUT29hT0lDUHNS?=
 =?utf-8?B?VlErcDVnYytyNUFnSDVCRXMyZjIrUUpKeTBuZDVhZHcydnNlUT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4853415-0099-45e9-f1b7-08db98da0c96
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:10:48.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4/wO0EhAKTKbRpErPDqIP2nhNSkvlIUyf44An5md1hMA8S35WpuL8i4FCFkE01WrHbchrqVUVofGicgKZ9TRoH8MnYqHVhO8ntpF4QiadI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5504
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
> Now that retbleed can do all that the srso knob did, and without the
> dubious interactions with retbleed selections, remove it.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/cpu/bugs.c |  188 ++-------------------------------------------
>  drivers/base/cpu.c         |    8 -
>  include/linux/cpu.h        |    2 
>  3 files changed, 10 insertions(+), 188 deletions(-)

Not all of this can go, because ...

> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> ...
> -static void __init srso_select_mitigation(void)
> -{
> -	bool has_microcode;
> -
> -	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
> -		goto pred_cmd;
> -
> -	/*
> -	 * The first check is for the kernel running as a guest in order
> -	 * for guests to verify whether IBPB is a viable mitigation.
> -	 */
> -	has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
> -	if (!has_microcode) {
> -		pr_warn("IBPB-extending microcode not applied!\n");
> -		pr_warn(SRSO_NOTICE);
> -	} else {
> -		/*
> -		 * Enable the synthetic (even if in a real CPUID leaf)
> -		 * flags for guests.
> -		 */
> -		setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
> -		setup_force_cpu_cap(X86_FEATURE_SBPB);

... these (minus the virt bug caused by probing for microcode behaviour
even when virtualised, and the enumeration bug caused by ignoring
synthesis if host mitigations are off) are necessary for KVM.

https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf

and here's one I prepared earlier
https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=2280b0ee2aed6e0fd4af3fa31bf99bc04d038bfe

but these bits need to get into guests for the guests to be able to
figure out what to do.

~Andrew
