Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0D782658
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjHUJex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjHUJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:34:51 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D927A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692610488;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4b/EFv0qHaztDXTHIyGBeOD16brw7GKtmGys3s60MYM=;
  b=DAsuMXTCIk6FR69xDdniHnIAPfec7aSKsHQUplvwPdm8pYKmYpeuLZrJ
   Ukr0B2e+3m+zmDKaJC3m/pKNKcZKD/VfQu9Qncm0YDuopgCBOI63CpQN4
   LGdmqHwC+XHhGM0iCE2xtFlvLaxH3bOSB3sx0UWd2hVm8bs8HdsAiRmxU
   8=;
X-IronPort-RemoteIP: 104.47.57.168
X-IronPort-MID: 120115868
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:6XOXnaobVn+y3b6PLKl6CCpaISFeBmJ1ZRIvgKrLsJaIsI4StFCzt
 garIBmDOP2JYmH8eY1yOYvl801UvZHTydU3HgZupSEwFC0W95uZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GpwUmAWP6gR5weOzSFNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXADNSbD2Ciebp+52QcMJqmfV8M5PEGYxK7xmMzRmBZRonabbqZvyToPN9gnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3jeeraYSFEjCJbZw9ckKwj
 2TK5WnmRDodM8SS02Gt+XOwnO7f2yj8Xer+EZXhrKYz2QDDmDx75Bs+f2q25v+5q3OHAP0YK
 hxJ+RYcoqc56xn+JjX6d1jiyJKehTYeQ91RFuc95SmOx7DS7gLfAXILJhZROIIOt8IsQzEuk
 FiTkLvBAT1pra3QSn+H8LqQhS29NDJTLmIYYyIACwwf7LHLqpkbhxbOQ9AzVqK45vXtFC392
 SKirS4wnbwfgMcHkaKh8jjviTumu97MSQE4/C3eW27j5QR8DKa9bYuu+1nd7N5aIYqZR0XHt
 38B8+CF4ekID5qlmyuKT+EAWrqu4p6tHDTCgFIpPJA58z2r03emccZb5zQWDEFoMYAOfiXoe
 0jNkRhM/5IVN3yvBYd4eY++CMQCyanmCMTrUe3SYtNSY593Mgid80lGeUGUz0jpkU4xjbs4P
 5aLN8qhZUv2EoxixTuyAusYj7kiw3lnwXuJHM6riRO6zbCZeXiZD68fN0eDZfw466XCpxjJ9
 9FYNI2BzBA3vPDCXxQ7OLU7dTgiRUXXz7iswyCLXoZv+jZbJVw=
IronPort-HdrOrdr: A9a23:318nIa/1eZcJYB4IDaJuk+G+dr1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYVYqN03IV+rwQZVoMkmskqKdhrNhQItKPTOWwldASbsP0WKM+UyCJ8STzJ856U
 4kSdkENDSSNykFsS+Z2mmF+r8bqbHokZxAx92ut0uFJTsaFJ2IhD0JbjpzfHcGIjWuSaBJdq
 Z1saF81kadkDksH42GL0hAe9KGi8zAlZrgbxJDLxk76DOWhTftxK/mHwOe1hI+VSoK5bs562
 DKnyHw+63m6piAu1Lh/l6Wy64TtMrqy9NFCsDJos8JKg/0ggLtSJV9V6aEtDUVpvjqzFoxit
 HDrzopIsw2wXLMeWOepwfrxmDboXwTwk6n7WXdrWrooMT/Sj5/I81dhbhBeh+cz0Y7ptlz3I
 9Cwmrc7vNsfFj9tRW4w+KNewBhl0Kyr3ZnuekPj0ZHWY9bTLNKt4QQ8G5cDZ9FNiPn74IMFv
 VoEajnlb5rWGLfS0qcknhkwdSqUHh2NhCaQnIassjQ6DRSlGAR9Tpt+OUv2lM7sL4tQZhN4O
 rJdo5ykqtVc8MQZaVhQM8cXMqeEAX2MFPxGVPXBW6iOLAMOnrLpZKyyq4y/vuWdJsBy4Z3sI
 jdUWlfqXU5dyvVeIOzNaVwg1PwqViGLHbQIpk03ek9hlS8fsulDcS7ciFvryP6yM9vRvEyWJ
 6ISedr6rHYXCzT8L1yrn7DsqlpWAgjufIuy6YGsnK107X2w97Rx5rmWceWAobROhAZfU66Kk
 c/fVHIVbd9BwaQKzPFvCQ=
X-Talos-CUID: =?us-ascii?q?9a23=3Ar37SjGu5DtGICjWrYWzuSzCJ6IsmLX/wzXnUfHS?=
 =?us-ascii?q?XIlxCTqKkFkDK14Zrxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AF4ohhg+X823XNtxriAVzmVyQf+1Z7uOoCGEwqM4?=
 =?us-ascii?q?p/MjUaC9MCTiShyviFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.01,189,1684814400"; 
   d="scan'208";a="120115868"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2023 05:34:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFPDRSnDugxM8NrSbf5SCmkPQ469rjzTkC3UzS/mB5yYNZ9NWXfor5mKW30CIjz5o9EmOctMdb+UIiXo4HpSAgarFliarF2wY4Dco/JCHZE0TQH5cmMyoS1/qyH/QVRtVF3Ydy1X8G0ze/sXMhiCFhoHen69O+bN0c12ggeQpu8awORslXdniRLL5YoP/UKHfG35U6IB4oV7lE7ySviZH3LrMSPRoPzK/jOCpNKcI+/SWy+S2+s4ND74C9hqF6J7vrsOfpuQSDkykh7XNXygI/N433z1dlrjXX5wC5BGCMkYLlY3f9+8SaiiD+mqb5GU8ExT26XjWvLFLAT66GPVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZPxRFarpcpi6r7Mydrf2xJDDkMeXqnU8C/7JHYU/Zg=;
 b=LM0sQIYKG7VBzjXrsDAItg1PlTKXikHMyq6xMNoUcHlWHH5Mkin+Vdco0Wkv2KdoO6Z/WmZz0UtwvgesIvsePWr2AnHGe6vdsQtHoOvOXtC/3RRw2OmJeTnmYbmcsy9wdWnfq7M6m91EtRXv3QneanX2Z/d5bG41ltNN4dIu4vtvCZDc29/m0cdhJC3AZXGosTldhyP6KcOkofF+WC1+yrylyiLR1eE+lJYkbwkD2ITdnxsqmcL2HlqXzsQw59qSRNBYT9xDwHfu23JXVQI5OwHU9CDayvwjr0f5rirVZUcF0Z1HQdcE17fVMV7gg+3znzgGzzhQOBmpTLMSw6WdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZPxRFarpcpi6r7Mydrf2xJDDkMeXqnU8C/7JHYU/Zg=;
 b=ViZxCdIieqZC/ZnOLHDpu0yrgw3VzQuNGegvsMiH8QObNfaW5SfIUgUGsZD8ESF+OnyAHSq3mjf1Gd2J+8NM1yfeWaFsUDgv7IwWeX67L44619PfC3WNUovcE/X8psTxHhvApARNP4idG+kD1xMvmZN7JC4QNgvufPZXZ4MPdhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB7079.namprd03.prod.outlook.com (2603:10b6:a03:4e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 09:34:45 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 09:34:45 +0000
Message-ID: <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com>
Date:   Mon, 21 Aug 2023 10:34:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
Content-Language: en-GB
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
In-Reply-To: <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0295.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::8) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SJ0PR03MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 11248c0f-d3f8-4d2c-7d2c-08dba229dab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6HfskogLCVtY3VNShvfqSfApgy0KLzRKdOSOAxAxGwp96WDVNyhR3arkwzqYE0kGAKAZD+ZtPzdB3/DmwWebywvj7Joa785b999eKVRF0CT2b3nZJynzwwrv9l+HTim7PtYMzOEOJOWxbSsxkY4YrkvFwPOFPfq6Q6XptVjaWL7ehDaf+foE4hCCvmwlaHHdjkMYF1moMMa+xBY1po9AcFOfskzvweE65w88bNYYz5MEN8LCBtReFF1kuZwTZEnWfttvhPbhZMcxeR7RL4vNPqcS17DmmJuvqnsvTnEZNo2/95KoPK6eDEXfAjpxIQY03PktBzwkvG5OuHYZvkxY9eWyQawUMDymy6pyPPPhcM7aaLsJtOEuPpiOp+2c/vU9svdlV+ViSasI4NsZKeM8AlL32dDD6caEPI43+ulMYtUQ1ne5imAAmQlh7gou2FjJ7J8lo7cCo6+Q4NAoTECSvw2pRIgQDtJ7YKyXisxCFpfmuAyQadA9OUWUt/5ctijPvghRxwtH7XcFq2JN1wLQrPzD42j4XCR6dtzEtoM9v3XQr3mrWf7i3AFCITixJpNoevnLKeL9vXabXJgbyOzRUhFWwFIZDn8M3Le5CsTl5vTuk45GrvmwwzQdxPJzNRQorjTuqhA+nsKDWYqsSCmxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(1800799009)(186009)(451199024)(6666004)(6486002)(38100700002)(6506007)(6512007)(53546011)(82960400001)(31696002)(36756003)(26005)(2616005)(41300700001)(66556008)(2906002)(66946007)(316002)(54906003)(66476007)(86362001)(5660300002)(7416002)(8676002)(478600001)(4326008)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0RrSnFiQVFOditreFdiaXZvalNKOTBtT2ZrSGZIc2ZjUytlV1k4QjJqUjZO?=
 =?utf-8?B?RFBkWnZWM1pIaXcxbkFZRUtpWjdxTUEyMjBsdFkrRzJpTjFVbWorSFIrUnNh?=
 =?utf-8?B?VXV0NFVLTVc1UzhRM3B4NWRBMGlQSEorYXhBNklTSG8xbGQ4ejRCb1JWek9q?=
 =?utf-8?B?SmtnYktsdnNESTRrTVc0TGJiV2o5c016aUUrSTdIb0ZNTHNLQkwxb0NmaVVN?=
 =?utf-8?B?Ui9nU1pwdDRiYWtBY3J3dnhsMVcrZ0tNc1U2d2lSSGZzYXhSTFRwcXhhZXlp?=
 =?utf-8?B?ZkFIUUFxSzhSUkxwelNkM09qNmljNTFwdWlzTkhxRE5EMHRRTitxSFlpM2pK?=
 =?utf-8?B?UDdRWlNXWkRXY3VxczFnWEhQbFhqaXVpcElRTzFoRk9hZW0rbFA4WTlmZU5Y?=
 =?utf-8?B?ejM3Q0dBbDhsMldQUSt0S3AwQUJZUGZtVzYzRllJamp4YVQ2eGlIeUFpZkVV?=
 =?utf-8?B?QVpieHV0cEdCMlVtUG9ueEczSlNJRmtVV0ZmdTVJTnhNVFl5c3FPSnpuOFpS?=
 =?utf-8?B?dEhCbXpFNllqUStvYTBwTVdzN3VYZWRRT2ZhbVFhRUJIbWE4eXJHSSswaTVO?=
 =?utf-8?B?cEVLcC9LZTJyNURhVzRVVzgwZGQ5cDUvdXJmSk5xR01VcE54UGc1UkpWK3dH?=
 =?utf-8?B?Yy85bWNjZ2dFU2krLzNzOEI4SEQ1emRPWUVzRVFmczF3M0NIVFlzeGpONVFx?=
 =?utf-8?B?dzRpNE5RY200NS9IbkF3TS9sdzhLOG9QdWN4VjBZbnhSSE05djJnQW9Dc0Zx?=
 =?utf-8?B?ZG5GbXllZnRpWmRRcTcwTVVwTkV4S24wUDdBTis0czQ2dEVwMUk5UC9BYVBI?=
 =?utf-8?B?VWdHNVl3OWhZSDR0S2xLUk5Dbi9XVXU4VGRUT2hoL2tyMitxdXd5OVdvaVlC?=
 =?utf-8?B?OXl3TEowM0haSk9VazBBN2lTelk0S3pHY2hFTUtaYjdzOWduREpvcUZzc3hJ?=
 =?utf-8?B?cEVMbnlRbjY2RVpDVjBBRk9Vb2J4cHZnUENGSjdmc3Rnc2FvcDlXb2VhSjdL?=
 =?utf-8?B?SC91ZlNTdlhpaFkzM0pyaFZuOENzb3lKdEg5eldoZGd2OTFrazlkWWF2YWti?=
 =?utf-8?B?RXlWb3RmUytZcS9zK28vK0gvdUZCRWdMRVhXS2h1TzVhSTRjU3FqSTU2NnJs?=
 =?utf-8?B?eEpGb3o5Y1ZmK2hQSGlFWHRrblpQVkNOditqODNLMTFma1BHeWl1ZHQyUDJ0?=
 =?utf-8?B?U2wzMnQ1SWtuendITCthK3lrbDFGaHdlQ0tjMXpQcVZKa1pUektmblF4REFr?=
 =?utf-8?B?dEU5aEtIMlpVTi9OTlNDZkVqUGF5TVFNZlNUTGtDMXFHYXFjRFlDV2pkcUZ1?=
 =?utf-8?B?dklqcmhkSy9oMHFSSWxsQ3crdDByUEFOOGI4Nng5TTc3WjNqdlhBUmQxTFlh?=
 =?utf-8?B?UDFsa2RPWDhxaWhvNEdyTUhjem9zV1V1Y2k2OURJTzhSZ2l6NnRuQWdsSnNa?=
 =?utf-8?B?eHpYQ3VJRGpyandHam1xRGJwU0tpelBORFhGaFdhYi9ITDhFSVI5cnZLbzBD?=
 =?utf-8?B?YjN2M0pQUGZ3bDBWUEp2MzBFZWZCbWsvMzNsOTdSTWU1N1BMaWJneUpocGlh?=
 =?utf-8?B?SzZNZDZNQnNkNnh4TTVQcHM1S1VPNVo0VWVHZUExUHFWRVREV0tBOEtvTTVh?=
 =?utf-8?B?MkxWS0JBS0hNcFBSOEpLR2tDYkdYYXNSc01rTkk2OGdRSmJuRm9XSTBwV3pw?=
 =?utf-8?B?bXNhMG5PWVZGZStVVWFYZGR2K21vdWJ0OFlHWHN5Q3Flek5KRDNvd3FrNFFF?=
 =?utf-8?B?bEtrZFU2Zm5GWkFPeUE5a3pFSm0wc2xlUkMyaWQ0bGJJbVhQVnN2ZUFpbnRm?=
 =?utf-8?B?WFk0b2hZcGN0b0plV21HbTUzOHpHdjcvOXVhb1RrcGRFUXpPc0pKR0dIb1lL?=
 =?utf-8?B?MFhYTVM1WVpwQUV2Si9UT1M1OTl4TllvYkQ3akM3ZndJU2pNTXFhbmdwTXc5?=
 =?utf-8?B?VWQ0MjZBSWdsNldqM3JSbFF3bUhCTC93QjFVQ1ZhakZYU1dOSHFhclhyR0U2?=
 =?utf-8?B?eC9XL1BVZVYrYXlDNWZLanYvTlo3UTFCc2ZPZ3Y2emNlZ3hnNFhIRUc5SDFS?=
 =?utf-8?B?TE1aQkNKODJqSjhYaWxFejh2d1NZYnkzT2RyMCtzWUNGenZWQ3dFZlVvbHJX?=
 =?utf-8?B?K0xaSnNRTGFITGF2RlpSRWJBVXJnazMwenVYZFM3akxlaXozUHMzT1RNNWti?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a2lmZ1FmNjZoek9nNHRmVmNCTmdKTStMTS9QTU5QUzNqTW84Z056c1NLMWc3?=
 =?utf-8?B?UFpiVjcvVUh4dG41YkRld0VFL1N6Yk5HUGQ4RGtEWlVIMHUwd1JnUS8zemNF?=
 =?utf-8?B?QWVYNFBCQkRrcVBUWjF1WHNFeHFTazIvYW1QblN2MnBxMFJlVjZnakMwNkpF?=
 =?utf-8?B?L1YvdXhNemRiaHJBNGswcmtETkFyVGVlN1BHWEh0Y0s0SmR6Tzc5bzFXc2N4?=
 =?utf-8?B?WThjKzUySkJpdkpQYlJwYjNxbXhjN05RRFlNZ252RE9KcjhaSU1RTjhEWkNC?=
 =?utf-8?B?cVZQVWlHZE9EUnNlT3VLSHZyZm5QMndISVNlZGI1dnhYdmVVWGFxWmFBalRn?=
 =?utf-8?B?cVNTS25hNXlvNjNQdTBUYTM1RFMwYk5OTTZuY2x5ekJHK3FtQ1JhblJ4ZUpx?=
 =?utf-8?B?d0ZVSzNtK3B6T244bHRWRThlV1JkeTcrV2ZnNW41UkYxeXRhMFNhbURQS1FM?=
 =?utf-8?B?WnU2b2JpaXlOMXp5ZU1KOXVCSE1CaWJUeDdaK2R2VytZQmJkVnhHR1MvU0sy?=
 =?utf-8?B?RDVCNGQ2S2phMUJwaEhPUmpvTUNFRXp6eVpvTGFPVWgxZFJ1R3YwRVRML0Rs?=
 =?utf-8?B?aVlrNUt1NjFiRlVNWWJBOE9pcUJ2eDBjV01IbjRLTW4xUjVTVW5WejR4cWF4?=
 =?utf-8?B?ZWhidyt4M013WDBhSG02cEl5RGo2bjJOUVBLNXBGbUwxMVdLeUE5TEFNT2Nr?=
 =?utf-8?B?aFFRcUhVRTRmaXU1djB5VFJBWEsrdTZFOEJhQTF6eVJBSzhPRndUcmx3b2dD?=
 =?utf-8?B?dFJuUCtqZ21zK2pIMjlpTGtNV3JaOWhZR2hyNDE1ZkxkUHd3cFBhNXFVNkRo?=
 =?utf-8?B?STdkWVczSUlaYXFrTnV0NlVBb0NqZkFoMUdSWGZtd2JCekJ0NmJNdmtGWndW?=
 =?utf-8?B?NVBXaGtSdFFrc0I1VDFSUFV0S254M3JlZURCcU56d3ZCZ0dTeGkxZ1pxNkk2?=
 =?utf-8?B?UVhVaXdlM3cyeHFnQ0ZBd0J4SmRNZ0tQMFZYOEVXOElYcUd6SzBadnVTRWZk?=
 =?utf-8?B?NStPeGgvTkdPZ1kvaGIxeWdCalBxcFp3eGNOUUVhdUhZZk9LYzJBbHpwODlv?=
 =?utf-8?B?U1RHSFlrMWVQY254WkZ4WUxBemZZY21RY3NnMXdubVdJNGszQU45UldIWSt6?=
 =?utf-8?B?YkJrRjB3ZWp2dEpYU2ZkbzVSQkN6OFphM05zSTQvYllXRk5Ga2wrVHlrV2Mw?=
 =?utf-8?B?eFFwQXRwQkpERFF5bVhmaC82Q25DbkxKbUlzWmtvWng0UjVmcWRaWG5IbTRs?=
 =?utf-8?B?YzlGeUE3bCt6YnBvTCtxNThRbzFSb3Z0bHEvb1REY3A1YUZVWUN4Nm9Gd1BF?=
 =?utf-8?B?QTh2NEZnUU9Xb0Yxc2NFVGJwQk50b3BORVdDZWJRWmxSNlNXWWNsVVpZeUlP?=
 =?utf-8?Q?+0bb/j9wBU/9SS4XV7mXuavErv8M7tf8=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11248c0f-d3f8-4d2c-7d2c-08dba229dab6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:34:45.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNEWTjtp1VcR9adHbhKAB3oU1nFdprYMNmzDaBgVf6pCgop1+3q5GwNkBOW1cmMjSp5tvjn1Z1l0MveYYKTYbgXj4Y8KySNhh/hS7zA5oSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7079
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 2:19 am, Josh Poimboeuf wrote:
> The IBPB_BRTYPE and SBPB CPUID bits aren't set by HW.

"Current hardware".

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c381770bcbf1..dd7472121142 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3676,12 +3676,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
>  			return 1;
>  
> -		if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
> +		if (boot_cpu_has(X86_FEATURE_IBPB) && data == PRED_CMD_IBPB)
> +			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> +		else if (boot_cpu_has(X86_FEATURE_SBPB) && data == PRED_CMD_SBPB)
> +			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_SBPB);
> +		else if (data)
>  			return 1;

SBPB | IBPB is an explicitly permitted combination, but will be rejected
by this logic.

FWIW, my patch to Xen went something like:

---8<---
         if ( !cp->feat.ibrsb && !cp->extd.ibpb )
             goto gp_fault; /* MSR available? */
 
-        if ( val & ~PRED_CMD_IBPB )
+        rsvd = ~(PRED_CMD_IBPB |
+                 (cp->extd.sbpb ? PRED_CMD_SBPB : 0));
+
+        if ( val & rsvd )
             goto gp_fault; /* Rsvd bit set? */
 
         if ( v == curr )
---8<---

~Andrew
