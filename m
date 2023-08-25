Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0E78814B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbjHYHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjHYHxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:53:22 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7901FDE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692949999;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v3+JDwlNWAiVqJNy5SDnAwARq+O9kOhO2tNvGaHOIwg=;
  b=VMoJ//kSDkzzUe/d+hxRGgSD7XCaE1/dna02NfyREUDMI89+hScmj4j/
   OYgWj1tG/YIK6nIwlXW9USYiQ2Z1yjtjkS7cAwzISaiYrYmOu2kJhth8k
   ujw0fbeOH8VvkIoRziU/pgRXqaCmE0IzWApL2DRO62G2kCfTfNNUet+k0
   I=;
X-IronPort-RemoteIP: 104.47.55.108
X-IronPort-MID: 121036591
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:KVizhqDWst/wyhVW/0Tjw5YqxClBgxIJ4kV8jS/XYbTApDIh0WQBz
 mQWXjjQOPaJMWHyeYxwb4zk/RgG65WBx9FrQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMscpvlDs15K6p4GNC5QRnDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw++lqA0Jnz
 +MkIzktRBzbveuE/JGJVbw57igjBJGD0II3nFhFlGmcKMl8BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI+Oxuuzi7IA9ZidABNPL8fNCQSNoTtUGfv
 m/cpEzyAw0ANczZwj2Amp6prraVxHugBt9DTdVU8NZxrXnUhVACJScWC3Gwiv+8mlXhd+5Af
 hl8Fi0G6PJaGFaQZtvlWBy9qnmJlh0RQdxdF6s98g7l4rqEvS6aC3ICQzoHb8Yp3OcyRDo3x
 hqKksnvCDhHrrKYUzSe+62SoDf0PjIaRUcIfQcNSQoI5YmlrIxbpgrCUtt5Aoa0iNPvED39y
 jzMqzIx750ZhMQWkaC88l3dqzupqt7CSQtdzh3dWWS37wV4TJSoa4yh9R7Q6vMoBJ2UR1+Dt
 1ALnM+R6O1IBpaI/AShSfsMEPeK7u6BOTv0iFtjWZIm8lyF/X+gO4pX+jBlI1lBKdsfdHniZ
 0q7kQxL6ZBQPFOubKlqc4y2FsImxLThEtKjUerbBvJSbZxhXAuG+jxyf0mW3nCrnEVErE0kE
 ZKScMLpCGlAD61ilWKyX71Eie9twT0iz2TOQ5y91w6gzbeVeH+ST/ECLUeKaec6qqiDpW057
 upiCidD8D0HOMWWX8Ud2dd7wYwiRZTjOa3Llg==
IronPort-HdrOrdr: A9a23:0JEC2aB8YohkAqblHejKsseALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPH/P5wr5lktQ4OxoS5PwJk80kqQFnLX5XI3SJjUO3VHFEGgM1/qA/9SNIVyaygcZ79
 YaT0EcMqyPMbEZt6bHCWCDer5PoeVvsprY/ds2p00dMj2CAJsQizuRZDzrdHGeCDM2Z6bQQ/
 Gnl7Z6TnebCD0qR/X+IkNAc/nIptXNmp6jSRkaByQ/4A3LoSK05KX8Gx242A5bdz9U278t/U
 XMjgS8v8yYwryG4y6Z81WWw4VdmdPnxNcGLMuQivINIjGpphe0aJ9nU7iiuilwhO208l4lnP
 TFvh9lFcVu7HH6eH2zvHLWqkPd+Qdrz0Wn5U6TgHPlr8C8bDUmC/BZjYYcVhfC8UIvsPx1za
 oOhguixtFqJCKFuB64y8nDVhlsmEbxiX0+kdQLh3gadYcFcrdeoaEW4UsQOpYdGyDR7pwhDY
 BVfYnhzccTVWnfQ2HSv2FpztDpdnMvHi2eSkxHgcCR2yg+pgEM82IogOgk2lsQ/pM0TJdJo8
 7eNL5zqb1IRsgKKYpgGeYoW6KMey3waCOJFFjXDUXsFakBNX6IgYXw+q8J6Oajf4FN5Icuma
 7GTEhTuQcJCgzT4PW1rd52Gy32MSeAtWyH8LAa23E5gMyyeFPTC1zCdLh0+PHQ58n2AaXgKo
 OO0dxtcrjexFDVaPV0Nj3FKuhvwEYlIb0oU/YAKiWzS5HwW/vXn92eVsrvD5zQNhthcl/DIx
 I4LUrOzYN7nwyWZkM=
X-Talos-CUID: 9a23:/cMfi2ByFLjdbET6Eyho6Uw3M/o6TnbU7F3ce3WxO1pKeqLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AO2Cv0gwoK0f4pLAoQCUXJe1+bR6aqL+DLAdOrYQ?=
 =?us-ascii?q?rgcnaHydbPTKNl2ubfpByfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.02,195,1688443200"; 
   d="scan'208";a="121036591"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2023 03:52:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx6CrGfVdviCj69tV5bAkojlkZY4P7ITxov1cdJ0tsUrEfskNpYgSqgsLukzwFligaYmzV6TCnQA+TX6v08kDySU+XXts7EO+GnsqxVwlV3/SzTxkE5xY0dI3rCFwgMVFgOfn+oqSbyzdNT7P664r+JNm5XSMzhdAgwA+0n/zrPe9YTcG+kDkSKKKq2QiPaw5VoieE/5VyVEmLzRD2YjDFoSmZxalgKua+EHUzK2HBdi9m5JGsvl11E1m/whfKinEy00SOpzUPXwVBTD+iBifgdtNDhXgZdsmm++Vfy47svOSdTYL2NJy9qOIhrgOyKM+JsSY6rTMBcxiaFJnrPx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmTV0TrL1Yz6HpnYt/kh5nELRNLjWC9TQC6KVGUk+K4=;
 b=b/1pzTimSdJpkOw6YbGkeCUH42WcMwQrldZ3fnF9KkUaEbTsj5M4uQ7wHtcqsWoZX9fuOfsVZy0O4cCtGYDBFNPSkbWYbDZOvILBl8eodugWVgOKYCsEc1Ykz9UZY6vAN7Dwi9dY0FRRuHHkf5D2w5ZN/H4LQYlDLF7PhL+lk6juSBVeQaOug33/kPnEEfvJqc07L0sOXVnFFuMC6KhTob/rOy5dra8m7nAcihT8zOr4Fj3QYGF3t1D1Slao3e80MVFG1t3p/7cfGlKjlkcMLTzq//NasgTo0uxYegGQvTo6+XvcFTu6ZCv3vd1ahlqYX/kVNz9b679zwlJGB4RsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmTV0TrL1Yz6HpnYt/kh5nELRNLjWC9TQC6KVGUk+K4=;
 b=gx3H2te+8TSXfyoCfyr+RHtyr0ks3+HHJUDXrEMWHR3nkfa492jYnENB+CZtP5y/yBt1ivM2zy//ssh/+fn5Ih67L1T8ve4SE+QCoPPQsU9Ha9/7UFL1tH4qjhrXd0jmdoRl/QLphzCbaXI0IHEl1km9bsdWm7JXIiDrRFrcpLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA0PR03MB5513.namprd03.prod.outlook.com (2603:10b6:806:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:52:47 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 07:52:46 +0000
Message-ID: <cc4f4937-c696-cb32-939d-bbeafc4210b5@citrix.com>
Date:   Fri, 25 Aug 2023 08:52:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 03/23] x86/srso: Don't probe microcode in a guest
Content-Language: en-GB
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <3e293282e96b9fe1835c8bd22d1aaac07d9628e7.1692919072.git.jpoimboe@kernel.org>
In-Reply-To: <3e293282e96b9fe1835c8bd22d1aaac07d9628e7.1692919072.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SA0PR03MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c700d69-d728-4209-fb0d-08dba54044d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnVfAnWngw/2BDvz+YG21EE+gYVpb51dukbtdiHhRP7XLSw3FkoCaMnwIhjwJ30WWGWGAKqWkWzC8fQTGPQ6uW5vifQylh2mtSzDgaF1di8cjuCogOTFZpLhbAXLM9/P5FNtj4gLSIudUi5mTEIbdNJdYOgbLT7t8LcghBu4kkxK03M/v/kJyGAmMkYt79tDm9ASm5GkQmGRvwvU6wt9xa6T8Sp81k2BnA5C1PCVASkD8K1Erj5MPU8uYmM04KupP2jFTytfN9MEBVkbPS9y+lhOwia5KBUfM3aNLKJdjX97a2ZijRPrPsEY6bsBB1sm9YbCRmDsoTaRykz5op5e/6Vw18YBqVltuBEa/xAEftE76/384MCru7iDAYnXQ88FvfA5kKo0q8G3L+CVcg66RwBZoDbysCsNPcuc+EswmBoHtcsSq3GRVJUdeeV0URCMMEFpGwtmdkKWkxetc3JXNrdM3soFY4PHUXwApFVMHTFhPpbtLVZrDclH/C13kaIlVS2ZrIlv25a0AG65K8rGPN1k0oJDZq7C5LCUeRU+q80tnK/A3sAzm5ePDRBswwoCbj2IsUkPhun7FgyXHS/dpb42beYHwNkuW6AeNkfQ5l6nUe46+cwnwdYF95LXSK2TNhoIdebyebeYbuqRBNrTqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(186009)(1800799009)(451199024)(66476007)(54906003)(66556008)(66946007)(316002)(82960400001)(478600001)(26005)(38100700002)(6666004)(41300700001)(31696002)(53546011)(6486002)(6506007)(86362001)(2906002)(6512007)(31686004)(4744005)(8676002)(8936002)(83380400001)(2616005)(4326008)(5660300002)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJ4eXBOYkYvQ3Y0eVJOWjJyOWlLK1ZubVZFZ240QVBWaU9SYmxQa09tQ1Vi?=
 =?utf-8?B?TGlxODhFcnpmaUhnRmovOFdSbjBrOGxleHc1alQ5TXYrdFJ1dVBZbFp2R2Zj?=
 =?utf-8?B?cGh5QXh5NWpiN0w0TEwrYVgreHpEemRpcGZmMjEwOXNnMnlYZFFKYXFpYVUy?=
 =?utf-8?B?dmx0UEZZWDVYUDFFMmJCL3BveU9TK01yckxyQVZiNXB0VEpId2ZPQU1DQXBF?=
 =?utf-8?B?ekJ6MmxFZVk1aWRyWVVyWUZydmJuWXZkOVVWL1lta1ZPMDJicG1SSVcrc1hX?=
 =?utf-8?B?WFRvZjhOakpkV1Jta0pPbERuVkVjUWtZbnhqamVSM3oxd2hGMlNObVEzeVUz?=
 =?utf-8?B?Z0VDSjFxOHFQdTN2Vlg3SHVJTTVJTmtjSmFZUEtJS21LYzZYeFoyaklNUkU5?=
 =?utf-8?B?OCtNS3lONXhUa1ptVWNIL0ZDU2JybjF6YlR6V0FjYlhmd0JQbFJxZEFWVFFm?=
 =?utf-8?B?L0dCY3VIVlIyR3YxanNoTTc0a0lnYkRmU2krbGdzcTB5RTM2MEU1Nkl6WWdo?=
 =?utf-8?B?ckxBdzhlRWM1MGhWRWFRT2dsV0F1MHpMZ252RjA1RDg3aW11V09wWlM5cTk3?=
 =?utf-8?B?dE5zWCt5VTN0UFpZK2pCbnNzaXlpVS9aU1cyLzFHbjlUQkNlOHhPMmJ6QTgw?=
 =?utf-8?B?RmtkaExhQnVBR3crTHp6WlpPMmZkU0lZMjBFZWFZcnF4Y0pqak84SnVvbWtU?=
 =?utf-8?B?NmZic2ZlQUswTiswSWpUV1JCWXFZaDJFWW5MZHJOUWZ6TXRadkxQQ2VTc2dY?=
 =?utf-8?B?QldDQjdvWitDUERMM21PZzNYLzdUSmtCenhhbCswM3pNbU5qZjdabEtDa3RH?=
 =?utf-8?B?NkpGOXVNUS9Ia1Q5NVdDTElpN1NSZTNrRWNYT29pYXNtZHVIOUpmVWw0NGhz?=
 =?utf-8?B?elMrU1JHYUg2OC9VMzFCV0NZMmlIKy9CM0tCUmwzYXlyM241akFTWkpHQVhV?=
 =?utf-8?B?czNsVzhVWk0xWUw0dDFnQ3pQM3lKM3pkamwzWkZxUWh5Sld4bFJ5ZzAraWRx?=
 =?utf-8?B?aElNMHJyVVcvWUJpR3lFS2FvZEt3RUtab0JZalVZcFM2TTlwNVRkdWZUN1Vh?=
 =?utf-8?B?Z1VVNW9mSGlWcSs5b3hFMS84d2FSRlNZNUVMOURQUzZjM2JuTmlBVFMzME1X?=
 =?utf-8?B?dmxaM2dkRXBiak50bU5icCt4d0FGeHhJVEYvcnBxd2d2MGlRQ1g1am9CTDN5?=
 =?utf-8?B?ZGZkRm9xaVJNSzhEMi96dkhOUkl4TnJxSTlEQjJhQUpvVU5TZGxJLzNCOFlW?=
 =?utf-8?B?VkdrNURLVmJYT2NmbGhQMVY2Y013TE9zNG1ab1lWM2F6V0ZVWWV2dzZIaUdW?=
 =?utf-8?B?ZWpmS2p3c3BPbThUQy83NmdTMkkxR0NHS3FVUVFVUmhSUzJLRHJ1ZkIwbVlZ?=
 =?utf-8?B?M2R2Z3EvenpheFl5NUgwOHNkVlpJQUY1TnJxV2dVTTNvczR6bW0rUVZvOFhR?=
 =?utf-8?B?UEVRV0JaOEFLTlU1SmNrdzVwTVN0WTE4MGNhdWkvaTlIT3gvYXNONVpkU1Ro?=
 =?utf-8?B?eWRWWWFoT0Y1QWdZeHQrS3B3ZDZ6TjR2Uk1aUmdZWkRkd0VYZVhtd3FmTDVV?=
 =?utf-8?B?di9DNTRBa0wvcVBseGVXU2lZdlAySG84NmREVkFrUm0ybGU5Wll4N1RrTkpE?=
 =?utf-8?B?WkRWT1prenVlaG5XY3poMWd4bGhDUlBrOGlXOU9GUkdBL2R4aEFwMG9yeXJi?=
 =?utf-8?B?QTR2cnVnM3FhTDUvZ3hUcEtHVURvaGtKUW15dXZqZEpxTEVVc1FMVDNYQnBn?=
 =?utf-8?B?VjFYOVdPT2RhWGl3Q1JpZWlUSFYrOUZBRVpTTm5aejM2aEsvMElEeWRkbFVi?=
 =?utf-8?B?cWYydCtuSHltcVN3QytSQ0crL0xJUkRKSkdraGJOeEZtYTBsb3JRMURYeXdW?=
 =?utf-8?B?NVhsTDEyQWprWXBnMVBXdW1nUzg1bTNkWTdWNXhaL2UvNW5mOUkwa29CM3lL?=
 =?utf-8?B?V0hDSzdRVjdpZHJsc05XdksyNEF6RGNsSERkN3lXRnd3V3k1c2RoT1dkaVBD?=
 =?utf-8?B?ZnpNVjFsY3R2RzdHN3g1R3h0MStvc1JCZVQvZTUzWmVGSmUxWDFNL3Z0SFhH?=
 =?utf-8?B?blBFTDhnNDdZcTBES1kxbERGZXhqWVFrK0NNYWIwOXZrWFU5YnArYklBZFlz?=
 =?utf-8?B?c01HUUNkcVdiUThzS3VBTUw1eEZRQUNwWDZ4N1V0V0xhZlRzOS9Na1o1Wlk0?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aHF4clR1OWhJd0lkNi83RUxsSVhFaUNCcTl1WUpzbHhUQmhjeHpRR2NCNlMv?=
 =?utf-8?B?NWlWYm1nY3ZzSWN0YVkzZitYYnExQ1liblNxWE9TdkVONzFUNFB4TkhwQU1R?=
 =?utf-8?B?UkF0T0hLWm9xSFhyWjZhNjJ3NmZCWEZMYWVHZThNRlV1WEVyaFh0THM3M003?=
 =?utf-8?B?aXp1WXZFeE5GejBWWkVrTU13d2poVHlIUXhMM2FWTkdvVnVvZFNJekJrdTJN?=
 =?utf-8?B?QUpRazZRS3Zzb2xkbll3TXRWYjE4bkhBS0NBWHZ3aGZCREJiRDUrWm5mREhC?=
 =?utf-8?B?b1hSWGpMOERkbEVZSUMyaTFlOWNVTEJYdlJ4SGN4WTZPU0RxSnJUYVpPWWJ4?=
 =?utf-8?B?ckhKODl3dU83S0tIaENwM1ZFWHlZTmk0OU1ockdTQUJpZjY1UlVhS3NiOEM0?=
 =?utf-8?B?SVBhcXpSY0MvanBqTEpxVGF3dU1UTkRPTGY2Sm5iVXkybzBCcWUvdUh2cDR3?=
 =?utf-8?B?VDhUQjl5TkJnQXExanJodmxKbU5yVWJucXNtQ3hhWmxWQTNNZlVJVnJpYmdj?=
 =?utf-8?B?NFRKbEkyaHB4b0hHNGdGTmRlWjFBNVF2SXNJdk44L3FsOXNhbHlhQW15TFhL?=
 =?utf-8?B?VjJ4QmlEV2NYQndTcTFBV3F0amJRSmxGMEZYNWtuRE9HTDZaY3lXKzIyWHFR?=
 =?utf-8?B?dldjc09XMXY3SVVzVm4rcUQ4bUMyN1YxbVRhYlFhU1hJSjh2K1J6REFpcHdC?=
 =?utf-8?B?UWdwRmRmaFNRU3pJVVNvbXdKM0x0cUtsaGFPTVpoVmJlb3JwMmVuVGFkUDgv?=
 =?utf-8?B?b1Era3ExVmw1YUgwdlF1SXhFLzRIY1JnWVA1UXJRT3ZraTYrUS9DNUZuUUhy?=
 =?utf-8?B?ZEdqME5YN1R2MXNhdGxrTVBhalZ6Q1ZkcXI3c1l2cjRPSHVzaDBHaVhaQzBH?=
 =?utf-8?B?OTB3OHZXbmpPRUFwbVlScVlLbDZ1SGZFYlJsN3pVNWFveHFzb2FobUJnWlVs?=
 =?utf-8?B?K3lvRmVYMXN2STB2cHlUdU16OEMyQ05CQXAvNUJqWVlxMlQxSzhYY3IrQ1Zl?=
 =?utf-8?B?OTlDYnlKRUx5ckE0WTM5ckhHMkVVUUpwUDFkK0JFNG1OZDl1aVN3ZG42UjRV?=
 =?utf-8?B?SzJDWkRjZGFZOUVzVG1mTUdvWkNQNnd3WFVaZ2pudUVrMzlzUkVjVGw3ZXZC?=
 =?utf-8?B?NmFOV2tJZzJhVXpXNXBsM1Y5Tlh6N3JCOEJxdzJFSm1nZTdSdzc3eHJ4U2Vl?=
 =?utf-8?B?MlBRd1BJV1dnbnZVeHgxcnRHcDZLMTlNWXFPZTU3Nm0yQ0VJdyszTUd6a3Ex?=
 =?utf-8?B?VXh4ZWs4YXFiN2JjQkRMSGZEbldHbHM3QVpxNzhHSXNSZDh3TzBCdVBCQWFQ?=
 =?utf-8?B?SnRtdHp3MXY4eEVTQ001Qy80V1FtSXZlNU5oeDhKQXZnWk9oRmpFaCtWbzR3?=
 =?utf-8?Q?uJODZaiPAvX4VcaHSzMDyGJkKTzPbA9Q=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c700d69-d728-4209-fb0d-08dba54044d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:52:46.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAQoymVCNALzj2VFwG0bhb54F23xxSt91YL/ofgL2fae3faFZzckXH7FDiILF1KGMhCbxaVbTa2bSlY6WFezoKtGI5NWdtfxy8RNcoq31uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5513
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 8:01 am, Josh Poimboeuf wrote:
> To support live migration, the hypervisor sets the "lowest common
> denominator" of features.  Probing the microcode isn't allowed because
> any detected features might go away after a migration.
>
> As Andy Cooper states:
>
>   "Linux must not probe microcode when virtualised.  What it may see
>   instantaneously on boot (owing to MSR_PRED_CMD being fully passed
>   through) is not accurate for the lifetime of the VM."
>
> Rely on the hypervisor to set the needed IBPB_BRTYPE and SBPB bits.
>
> Fixes: 1b5277c0ea0b ("x86/srso: Add SRSO_NO support")
> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>

Thankyou for doing this patch.
