Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBF7543BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjGNU1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjGNU1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:27:39 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE3D3A91
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1689366456;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rpP5syiEzlvxBXsMgvYv8Pc9rxSz41uMJeYEL9MRNuI=;
  b=LWj9/mfhpfSsiyBkjjeeFZ1bF0bQYTmBzRhOJ5XZuWijTtbrN5JTD+uv
   /144lumxMZtOJdO9miFwzjfXW3l/knwr9M1DFhnUzNWqtgpLSr1+bRbQ/
   ALi4vId3J5eX6i9EIdQVuaNfge7m13jRQNGTzvwoW1qtiUBzU/lf81+qB
   c=;
X-IronPort-RemoteIP: 104.47.55.105
X-IronPort-MID: 115573207
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:Z/q7x6D2DdOKSRVW/6jiw5YqxClBgxIJ4kV8jS/XYbTApDkq02QHz
 jZKX2qCa6qCY2KmLYglbtux8EkGvMTVnIRqQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMsspvlDs15K6p4GxB4gRkDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw+8tmUWhz+
 sYhEjUgYEmhnc2q3LSXRbw57igjBJGD0II3nFhFlGmcKMl8BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI+OxuuzW7IA9ZidABNPL8fNCQSNoTtUGfv
 m/cpEzyAw0ANczZwj2Amp6prraWwH6kA9hKS9VU8NZYqWOo93VLNSExdnbguOerj0LuedJAf
 hl8Fi0G6PJaGFaQZtX0QRD+oHeCpRMac95RFfAqrgCL1qfQpQ2eAwAsQjdfZZomvcktSDoC1
 1mVktevDjtq2JWRSHSA5vKXoCm0NCw9M2APf2kHQBED7t2lp5s85jrNR9BlEIa6idr6HTy2y
 DePxAAu1+s7jsMR0ai/u1fdjFqEooXVSSY26x/RU2bj6Rl2DKa9apCl80rz7PBONo+VQ1CN+
 n8elKCjAPsmCJiMkGmIX78LFbTwv/KdamSE3BhoAoUr8Cmr9zi7Z4dM7TpiJUBvdMEZZTvuZ
 0yVsgRUjHNOAEaXgWZMS9rZI6wXIWLIT7wJiti8ggJyX6VM
IronPort-HdrOrdr: A9a23:K09ZyalAaJPq5w1u94fxHSCOvZvpDfLo3DAbv31ZSRFFG/Fw9/
 rCoB17726QtN91YhsdcL+7V5VoLUmzyXcX2/hyAV7BZmnbUQKTRekP0WKL+Vbd8kbFh41gPM
 lbEpSXCLfLfCJHZcSR2njELz73quP3jJxBho3lvghQpRkBUdAF0+/gYDzranGfQmN9dP0EPa
 vZ3OVrjRy6d08aa8yqb0N1JNQq97Xw5fTbiQdtPW9f1DWz
X-Talos-CUID: 9a23:2VSZ/GN6anFy1O5DWQR2pEcpFfocSHjwwi7yOWCkFWBFR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A2Zp4TA1eosZnUihQSRIsqK1tgDUj0Y2QM3EUyag?=
 =?us-ascii?q?6nOqpbjVuKTKR3Ba3Xdpy?=
X-IronPort-AV: E=Sophos;i="6.01,206,1684814400"; 
   d="scan'208";a="115573207"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jul 2023 16:27:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us9uT8xNEoNMz+Ge7CLfrbiLKe1zdRjW+7ekYZ65kunTi0jbwxf05Z0h7tpxF/aTbTLwJTvABlNkcQt/Hwet2rGJ29CEUHwQScWiL6iyUU51php6v4CLcnCu2YGPrzMdF+XO1K2jveoX+XD/4Kj/MVauVKgaVHOb2YhKtLc01KQxEd7/kYA9aH4xr06kfBT4Fzn+QZuX6Yq20U9Zw2iQ6LPC+d1baWFh4bvMm6/rcLUG2R6e6JhzeAr6S3hSBPRAZKi3HJNc5DgO8IJq+OfCCLdoqZBea1TGrRNnaOieLAVftLE9JUFZqwqt9ykeSyayq7xl+PQxmOcQwV6m9Zaitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS2jgHnm3c2T0AzhiCyTTx9RItJ0P2aTrahruwKOEwc=;
 b=RSebTk6HMPjeVMO1xvKAaigqXjyp2nPFdw+Uj3HKPmRU3H6DUZozsmRBXhG8kf0V0M0XCQwT/hNnjZmji4zU4RAXtsl4+Qpod8hDoYlltmIfkwVXK1x9FaAzqzzRcAeA9vwmOKrv9aRkZL6IEzJfmNbWVKfiHINkqlyKV9vT4G/K/wbnJ1esbEhUUjZ+wPJpbanr19eeFM73NR1G8HmYDTkY2HWrYDrHO5vkyw5aFXbIO3tyUtMHRj+WNxBQ8ql68giG7e2HyxpZnmwoorgvIorsjQ5iaUl5euDTm1hRAzqFRlpT2hHItJSCbTw+S/6uuZQ4q3MH4CEhpF/f6kbbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS2jgHnm3c2T0AzhiCyTTx9RItJ0P2aTrahruwKOEwc=;
 b=CXKXlCQ/6ELcUACMSVAGR9KZ0LVyi2h1IV4ex0I33flej/Pf80KUQ7YAk9gl9MP/VvXPgDTsQmX10LZGGJtE6hWhKtBq6PiFIM/wV17r9tUUz0eQQCfxAvsnMLPFZCeS4DSvWaIwtHr8f1drJcs9k+zezG3Ujv1JLvZ1xp2dfXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM6PR03MB4986.namprd03.prod.outlook.com (2603:10b6:5:1e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 20:27:31 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::f3c4:948d:a70a:de2a]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::f3c4:948d:a70a:de2a%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 20:27:30 +0000
Message-ID: <df0750e0-dd6f-7418-53bd-64a9ad1e0086@citrix.com>
Date:   Fri, 14 Jul 2023 21:27:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   andrew.cooper3@citrix.com
Subject: Re: [PATCH] x86/mm: Remove "INVPCID single" feature tracking
Content-Language: en-GB
To:     Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, jannh@google.com, x86@kernel.org,
        luto@kernel.org, peterz@infradead.org
References: <20230714183555.7DD052F4@davehans-spike.ostc.intel.com>
In-Reply-To: <20230714183555.7DD052F4@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::13) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|DM6PR03MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b2a4bc-64e6-4422-e63a-08db84a8bf24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWr2wlFpD3i+Rdpa1xZfUnF1yGJbjWY7YSg9m2Ne+MtsOW6nuxW4Z4vgE9yeoHlX/NehDbyI2WjLSxzd5JGc14mtBU22NJW7F9N2REBRoL6KO5dRva6Q+tJ6OvEW5bSURqMT+iwsCzi3XrjkZL5HWPAKt1o3aJ4FWMlNUISuBWNRPNklCroixioDj8xF4p8p9qCTjTLFPOi83pSuLbjboD03gUchPOHJWnDVKRKJD16f0Lgka8DR6InwPcd6bVLmFDoiQUYiVH4sJPod3RAs9AM+s7rcBpzcBVVc9AQIndKpK9l/jo1KFE4ChZ77uBPUXZDlWR7/HyEadQY33l17kkpB4TwEgJOWtlSx2jbkwcucODDKlfP4H4eszXLRCNDmaSB0ly4xfCxSEyBPQZ/AkQc/fvAE6eNelK3e+npGvk6trfJ8la93rhP2qweIZWpBfLRJBMkBqB92cj7Ykqg/L6jnTUyCTGbh6f15vmkst+PaUz3IQGNZpoIR/ydMURewZvCmEBcmUOFdAtrp3dOaCNJUQs7ECkjSojB8WdBRUSho9iDIREUe9hC/IxXL5QlbVefFpCzIf6G5LXNJzarse1y5ghgCVCbndUAOld6pzww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(86362001)(36756003)(31696002)(82960400001)(38100700002)(6666004)(9686003)(6512007)(6486002)(2906002)(478600001)(53546011)(26005)(6506007)(84970400001)(316002)(5660300002)(8676002)(8936002)(31686004)(4326008)(41300700001)(66556008)(66476007)(66946007)(2616005)(83380400001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEdtejlHRXFFb1Q4VGZIdHA3bDVWWU9sczBDREJSMkQ1VEZMczB1Q09TazNI?=
 =?utf-8?B?dnFxZy9wZ3BDdnpOdFBKenowdDZtU29KYS9xNVN2RFNuSkNlTEc0VXRIaXVq?=
 =?utf-8?B?ZkJ3VWs5b1ovVWRtSndyZDhHZkgxRlFJNTVxaHU3MVZXc29keHVWMlp0aEx5?=
 =?utf-8?B?WjBWSHlLUUJEQlhuNTRHdnRHZVB4dlBFcEdyaC9VZGJUbWYzS2NXV2E2eTkz?=
 =?utf-8?B?ajJzckN4N2YzMFUzVlJZb3BQSmF0emRTSThVTndJSEdOSk1qcXVjazdNbWhv?=
 =?utf-8?B?RmxmYnVBb3dQaGIxclU4LytQME1BaDhSMnM2bXp3eWtnT1g0Ri9hVzRubFds?=
 =?utf-8?B?d1U3cDUxV05MTmowRUZoL2RnQjdHSmRlZFdYMzEreTdJbmJiTzVDMC93U1pp?=
 =?utf-8?B?L1lSZlJ1d0NibDA0QWxBQ210ZUZ3cENWVm1tLzBIWVJnTlcwMnRRN3NZWlU3?=
 =?utf-8?B?N1pKQlBscmMxWm9SSjNRTVZocE5RNTNSVFA0VjJ1RkRkU29pUExTRllMaTlG?=
 =?utf-8?B?TlIrWENOVytsMDc4RGcvMnBPa0pzUFFZZC9ocUtndm41ZWdGKzNzWXpKU2Rl?=
 =?utf-8?B?UWQ4WkI4YVZzczlDOGlkRnNEOEY2Myt3UDVycTdDcjdnV0hTSzB0NzRidjNH?=
 =?utf-8?B?cjBNcVZKWmRjVWNaYURYVEhXM2NTeXBHaUkxK2NtUm84ZW4zSHVIL3hMK3ha?=
 =?utf-8?B?TDBXMjdqckJPM0VwaXNNUDRoOUJkMFZ4NmZLZ1VSdVowWGpOUXE4WHgwWXlH?=
 =?utf-8?B?TkZnTnprZE5JcmRxRVpTTDlQY3dkdEM2SzVnLzk4dnhCUThncUVibkNMZjhp?=
 =?utf-8?B?QzNNZ1BPRXNNeHRyYVdlV3NiS2VRVzA2RDdiNXUzMXFJNDNNZitBZ0pjOThq?=
 =?utf-8?B?YThnNlFzazBWZFZZNk9BY1pSTG9kNERhYUpvWnZOWHhrQjFtdFNiYjIrRldG?=
 =?utf-8?B?NVQ2a2NHb0k2RmJJNVhSc1RXOXZ3aXRHYUZVTzN5cTJ0MlY4R25SandRSFZ2?=
 =?utf-8?B?ZnVhaC9TRm10dHp5Z01OQnk4aDZ1Sk1UMHppWmkxNTNTUFVYdXgybXl4dnY4?=
 =?utf-8?B?a1hjQkw0WjUvOEtEdW1RZ3VpczI5Smk4NEpMRWV4WEdqd2oybVZLRFN1ZHBZ?=
 =?utf-8?B?ZEZwZ1NsMitEakFJNFRqNzNwRlJ2VWdRem1ncXpLenhSdWpIeG1ITjNkUjJF?=
 =?utf-8?B?c2RPVE8zbFVtZFpKNjVCMmNzdGkxNFJPN2FiZjcwZDY5RHBkS0VzRGt2WEZX?=
 =?utf-8?B?YnpzSlU2V284eW9JUmtKcy9xdmljWG5pdnFzUnZtZmdsamNKakNpc1dOSHVq?=
 =?utf-8?B?c054N2k1bXV6U3NyTkhTSmdLcjBudW5pQ3NoWHgzbmxyUlU0emVQOFg2bDly?=
 =?utf-8?B?WWM0UVNRYXNGR1Rpb2g5U3dKZU5QTmdkY1Q3TUhieVZyTjhUZlQ0MDl0dVNw?=
 =?utf-8?B?Qzl6WXYwR1N3eW5LWUlJTUhvOCtUc1N6amIrRDM3b3FjbVovTXh2ckE2Qm53?=
 =?utf-8?B?QnBzd0Z3SkdUcS9wSE95TGZlRUxpYnBYb3RkN085TGxOc3YydDcvZGJRMmVk?=
 =?utf-8?B?SGNMNUM3MDl3dGRqODBGNXdlT3RjbUplQzg4dzRIWFVvV3dQSWFmU2pRcjFQ?=
 =?utf-8?B?MmhhUGNTN1VKU3pnRVJXbDJJNUJaNWNqOTd6d21Gc2JMZG4vREVLc0R6N1JG?=
 =?utf-8?B?WmJBeDhacHJwTjVqdDk4SFpnNmY0d0RwRmhjNjM1YStjSTY1WVlsZDNvNzc4?=
 =?utf-8?B?RHFOU3FZNXdWaWV3SmNYRWdTNnlTeTBDN1g2WlFSUXRIUDdwaStPbUJ4eTZa?=
 =?utf-8?B?bUNCYUxqS0Z2S1p4SVVsRjZpRjNCVVBuN0JYSGx5eStCR25XTmZzVFV0UDRC?=
 =?utf-8?B?S29rQmlVQ0pXcWlCTFFRdFVLanZXOFNBMXdxRmdFUzcybS90Wmk1MUJrQ2Rs?=
 =?utf-8?B?RStqRHROWjd2clJvUnR5L2VFRklsRGpsRHhnbG9rU2VPdDVNbXovM3dOSkhq?=
 =?utf-8?B?Mi9IWXpzaXphbFFPZW03cDRQd3U2U2gxeVIrOEhrNWo4Q2gxZVZlTkJ4aWNO?=
 =?utf-8?B?aHY2dlZnVXE1TGl5S1BpbXloZS94ejFUeVVvK1hlelRtRFZKSG1zS0RiTWM4?=
 =?utf-8?B?WktBUHFrVWV6QVEvTFJGeTdiYS9uME5ZMUkyVC9WT3UrV2Q5VHk2cEpOeVgv?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2EsBCCH/WgC/l9iOKoZBXuLOtD2eQKI4QLjTnDQDa62NTwxUky5DBB6ZJjrfFOTDuRclKLgT0NTOISFxu/YJxTYrdWXx9hqtyY/DGNxZFfhVoaLSdcJc2S9wt8pm/uCvKfN4+FWZq+z5NbMKIYr3TI1qRuv8cQAj/XY0kUXc42ZlTFng6uE1nJjexXhfZXQrZ1KnXp/OW1uJEKdadv5ybNx15NHtKYHXNAS1iZrZcSJp3EszWYN6QeNgMpj0K8sjgfRNCNLUc5yVMWynXKgfUSYlO1bP+rcL/QUGnYsjQDsdNHLzmJUxlGaLddvzhog0ZtuANxE/hC7QBCMgHtXXs/zSWZ0SSmGKJ5orw7PK9i0VatDFRmL6xaOCwND34xvOY2E/UjFBJ1tLAsaMUFQjgYGlhBOmGr/CAGbF2MtWK3FUsY1BO8bsyh+uLstc/CcD4R/mqo4cV8DjncVJuzAaugrrPZxxpS77IZuOgBNPC1Z7/5OEONrBuECt/B1FTCJG2wgwqHWnIXjNvzHMsxVyzjdR6/soXqg3IWUoSic1SFXb8uzP1DW8qA+6fC/fslkClzvFXQmezvWKBl48Y+IaTt9I6P9Jw5urJnLlJbk703eBHaXvKyKNBsjqyajjarmaACmO+anEaZpMT3LhvfR02UeAKF3QmSj3HDrsdXV/nv9qYQ2ELv+LyLxnG2C9irJJFoiowJCM5Miae5H9wievIgMBhMl3MRWjoZaFoE3wadclIDWXTDq8cLnWh8sfQ7dW7PUrcHdX+uPTiftK+9i47VIFYJJLKVDZdm6loNFRHpyWliJVtc1zpJ5EJXSoQtmyxf2ogqVpgrS1GC+CXfU7J0CP1z22GjUCPMdHrEP0HDh9OqIacPsezZltz7vyne6pMl72bPOvzAg/GNcLl2mmqOibH8zQ8tSzz/6EgFkMnHI=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b2a4bc-64e6-4422-e63a-08db84a8bf24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 20:27:30.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oZkRvCbZnW6QPUmFG52UDlrRsTUi9wKNENlbsqb2qJoCrNwZflOt9NynNCdG7t0QXOfJ6jN1X7B4ar3uO2d9Z9f7rk9WHzNIxeQLxUW/KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4986
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 7:35 pm, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> tl;dr: Replace a synthetic X86_FEATURE with a hardware X86_FEATURE
>        and check of existing per-cpu state.
>
> == Background ==
>
> There are three features in play here:
>  1. Good old Page Table Isolation (PTI)
>  2. Process Context IDentifiers (PCIDs) which allow entries from
>     multiple address spaces to be in the TLB at once.
>  3. Support for the "Invalidate PCID" (INVPCID) instruction,
>     specifically the "individual address" mode (aka. mode 0).
>
> When all *three* of these are in place, INVPCID can and should be used
> to flush out individual addresses in the PTI user address space.
>
> But there's a wrinkle or two: First, this INVPCID mode is dependent on
> CR4.PCIDE.  Even if X86_FEATURE_INVPCID==1, the instruction may #GP
> without setting up CR4.

Can the SDM authors go and reconsider their position of (not) including
this condition in the exception list.

Or give up and just point intel.com/sdm at AMD, because AMD do describe
this coherently.

> diff -puN arch/x86/mm/tlb.c~remove-invpcid-single arch/x86/mm/tlb.c
> --- a/arch/x86/mm/tlb.c~remove-invpcid-single	2023-07-14 08:29:08.665225945 -0700
> +++ b/arch/x86/mm/tlb.c	2023-07-14 08:29:08.673225955 -0700
> @@ -1141,20 +1141,24 @@ void flush_tlb_one_kernel(unsigned long
>  STATIC_NOPV void native_flush_tlb_one_user(unsigned long addr)
>  {
>  	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +	bool cpu_pcide     = this_cpu_read(cpu_tlbstate.cr4) & X86_CR4_PCIDE;
>  
> +	/* Flush 'addr' from the kernel PCID: */
>  	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
>  
> +	/* If PTI is off there is no user PCID and nothing to flush. */
>  	if (!static_cpu_has(X86_FEATURE_PTI))
>  		return;

As a minor observation, the common case is for the function to exit
here, but you've got both this_cpu_read()'s ahead of a full compiler
memory barrier.

If you move them here, you'll drop the reads from the common case.  But...

>  
>  	/*
> -	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
> -	 * Just use invalidate_user_asid() in case we are called early.
> +	 * invpcid_flush_one(pcid>0) will #GP if CR4.PCIDE==0.  Check
> +	 * 'cpu_pcide' to ensure that *this* CPU will not trigger those
> +	 * #GP's even if called before CR4.PCIDE has been initialized.
>  	 */
> -	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE))
> -		invalidate_user_asid(loaded_mm_asid);
> -	else
> +	if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_pcide)

... why can't this just be && loaded_mm_asid ?

There's no plausible way the asid can be nonzero here without CR4.PCIDE
being set, and that avoids looking at cr4 directly.

~Andrew
