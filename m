Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6279E926
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbjIMNYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjIMNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:24:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D719BD;
        Wed, 13 Sep 2023 06:24:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DD2Gjt032101;
        Wed, 13 Sep 2023 13:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=BpdiG8EbRB2nFUwxIaGix0qIq5YkbzkYGjIZX8NK16Q=;
 b=clOHLGEQRvyT6qS/IXdxawv6BMfKHCiAo4D6RFdQLZO3smHftlvTgkXEunbEwthj435b
 U9WeyvEuwNrLAni2i/UAAiZM28D/0sdLDDqmHtuajYXKSYi3J0LfXPahnAamNuCMw70b
 Qs4XXaxXtBxysqp4i2gBTmoPnEf4V7EoS+/5zG17AplscTPKQceOU7uKwoOgw3sdIU1V
 u3jcywBFbdxGsUYKG8Eczw+e6cEWLRc5TNN0lJuUBwoutWRk4wnUWzR0MX6zQakaFPSa
 GWXAlqa939ej1OXdAmbtrZJXxjqzN0wJ7lJluQj4KxxlvXx/JXzc8Emk4jOdRvTuAzrH TA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7msurj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 13:24:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCXHB5014716;
        Wed, 13 Sep 2023 13:24:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5dgs0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 13:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGx5fU70b2PYGiX5XxECNMCduv+/M647SpNKmlSFFN7sbVs0DoL+Tfjri+v84pYzVkSkCznv+q7YSuNbVt1OaDq2WmYGxDUVQpIPDuiw6RbDGJxeu48bKi0xschGAtxn27iGI0B5eYjDsk/7fJ3COkarObY2IoIz9XghaJ9lLZWXAGqKJbTk8ru9rHEvFgmp1cGDQQWmLZiyqVUFIBXdffLmQB2rLVWdh1Qa5GBJltFEjijpcmd3KZxXyNa+4ZiEJyI3uKw+jzwA/39TJ+3fiJgt1pG4vNFpaMw6GFPSkcKFH21XJqIq62LnbxEm6u7WpR/dZI5hGyUNqVrW/bfUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpdiG8EbRB2nFUwxIaGix0qIq5YkbzkYGjIZX8NK16Q=;
 b=QluygVBgwxVH8mOluvxyaYl/j1QmXFo1QJCh3ycEHCJFwcF+TkTO7RBWAoiQPdn/9vTytOE3WHeg0dIrBzGBfEjw08rw1EcMSR9/5wRQgGGLsbnljP8CQeDNV8sq8V6Ubv9FZ7NgRqYGIvwXS1I73wP/8LJ9mEa5kWjbeh/pXyKdjiwUrMigt9TlAPizPnSfxj3bM9/AliIdnGA3A9Rmg43I0LIBybhCMh/spEEzBwDdUfHoQeDv4hI1BWyiTe0uDvenuJ0evFVuTHxyooqS/3ecTohDMR1uWSyQZ2R9cMUaEGav2tGYwnUxLHnj3aNzZWscGUBeTnfcO/l18l2CIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpdiG8EbRB2nFUwxIaGix0qIq5YkbzkYGjIZX8NK16Q=;
 b=g1d/f/PxQLtI/W8KYcpLDk9fDmKm/imcF585gVKjWsrxAyyc48uDoB5SeSf4Hfh39tdcIpfD+JKejwOrt+k0Dlt3JnywcUD0HGfZQsPy6MXJrYvMvU1a+yIh9i3J4qlFyZUkCM8PST6udI8Txs0Iarj6y6mzcv1WF5mxRm0H7XI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4336.namprd10.prod.outlook.com (2603:10b6:208:15f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:24:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 13:24:08 +0000
Date:   Wed, 13 Sep 2023 09:24:04 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230913132404.wepr7l7o5qegy7hw@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, paulmck@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <CAMuHMdVp10=AQDcC31OEvy2LPWSdjvHnbCKVtRtt-Re=7wr=1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdVp10=AQDcC31OEvy2LPWSdjvHnbCKVtRtt-Re=7wr=1w@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0237.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dd9473-cb06-429a-c331-08dbb45cb58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcd+OkoTVYL8zkgp8PpY44oStC6swd14FNlM6gETdFPxEdLSVkV3+JQ6o406Olgyf6Q6keXc8v/2JqPwlubbm72Dswhe1R/dKfrxrk17cqE+MRMTsLRtblxolHiPDHY6ebKsML6mx4abkjJnvfY8Iv5x6lQeUeWQCjC/owKbcgf1+GxYNd1s/wiYpv9uFgaUZ/CTjY95zXAeib/CWVTyB4c9UQFwLvTaNQFAGs6QcxG/c21GiOqNfyuYQyktYIxxY8cR6J6XRlL7OBOYwlwcRhYvxVjeMfuDPcrPQw3nRVYCtyAlfOWOH8jiTeJPoYsZ6frUAxLSbVRXxdJwV3rQHBV+JECKU/5P2OokWkbaHZr06UC2Q0bBC87/CgnzS4JCOYMq7ohuoqttFo31v0peoA2UF/AHjQ31vDCIRyJZ7l2JjB9NgNsB6wr7EG7mbADksU6ARKG10X4/0j4elpJpXRLAbS3tw/MASExGjlS5TsFc1WXVy9n09eLznIgHIv/7X96koyPWlel88zQ4prV3J/BuuCEmxnsmalDQbostTU9zDUiTjZnVIRIzSHt7+TBI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(6666004)(53546011)(6506007)(6486002)(6512007)(9686003)(45080400002)(478600001)(83380400001)(1076003)(26005)(2906002)(33716001)(6916009)(66946007)(54906003)(66556008)(66476007)(316002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3BLVnBoZkpncDNkeTB2eitwZlpQOGEwd0tucnhNMkx3NUg2c05ncXdDazR0?=
 =?utf-8?B?UG44bXpmaXFoYzJsQ3F2aTNaRm5WZGxTaVZwQ2dWNXlYT2trRFFhM2kvQWVR?=
 =?utf-8?B?YWdvMzUxY1FnUnppemVLa3hidmlucGdtOUxiVXJ1V2R0RlJFNFVEcEp1WlpC?=
 =?utf-8?B?YkZydGJkaC8xMDhOMXozaFBrYnJJbEdnMlBPdG5KbEQ3ZXBUNW02L1BxSE9T?=
 =?utf-8?B?bFI3UFlhQ1lwS1dFY2xSR3lPUmxSQW5UNEg1WmNrZVM2S0JSNzRPanUyOWND?=
 =?utf-8?B?N1Jvd0svMUxJYUlKdlRyRlBvM0VlNWtidk9zS1FHM0JXQURXMkpsZzcvN29E?=
 =?utf-8?B?NFV5THdDcGlLNFhhRnZ0RnZzdmNuSW1Gdkc5RVJsT1NVcUNZOFV6V3FILzI1?=
 =?utf-8?B?SklEZ0FSeW5PNEw5Nmk5bjNmT25ueWt5dm1nZTNqNmgvcVZXLy81Q2VJaDFx?=
 =?utf-8?B?YUxrTFc2R0dDVUlXdzYyNzQ0M0FFYmJST2MwNzRPZXErVGRnUEZqaEZDZ0VT?=
 =?utf-8?B?OUc1YXFNVEl0NVF5aUp6QXBLZ0YzUEg4dkVhTGhwaDYraEw4NHppTTFsNnJF?=
 =?utf-8?B?OUdMZUo3YWFPRldZeGtrTy9MeSt0ZXptNUloOXZHUzliNDY2NkpIV2lWVDZ3?=
 =?utf-8?B?bmZ6clIzYUcyMEgvME5Mc05IelNHb2pUSGpHdjhPbTQrSGFNc2t0NXdxQmVt?=
 =?utf-8?B?YVE5OVR4V0JSeXJ4RUwyV1o2bzRCMkhLclQ0S29CVG5MQWttVlJjMFFPYm9w?=
 =?utf-8?B?OVlWem9lYW1xVFJCdkwvTnM3aG5DdnhoRGF0V1pnNUhrVHRUejI1QUozR2s4?=
 =?utf-8?B?bnBBUmMzTGpmdEFRUDd3U3RkM2pJN1BWMk1JV0VDaEdTRFJMKytZOW5rUlk4?=
 =?utf-8?B?dXVKMTRrTXZhUFI1eDVQT1NwUUdXMFgyWVUzR3lqeGdGYzcwb1BoY1Q2THM4?=
 =?utf-8?B?b01jQUlzNzFDVlJxMXR6byt0R1lUeENnUGFHZkR4TlRaNW42Q2wvUEJSaUxC?=
 =?utf-8?B?VURpdFQ5MUJRUEU0bzNxRDUwVm4xK0VtbEFLU3dUV2phaEo2eU9xSzV0ZmVl?=
 =?utf-8?B?SzdVa0JUQkZQZlZhUDAyS0o4dHdjQTd0elNiazk4Q2MweWU4MFpHNCtldEhY?=
 =?utf-8?B?eTB6YUhNbjVNaGlsRWlnelBucko3QWYrWGlNaFA3c00zekpyWW9kTGdzZkFi?=
 =?utf-8?B?Z09EOGFlbFBScUQrWlBkT1FtelJlZHRIVmVwT2tSZTZPdTc2dE1oNitoR2Rs?=
 =?utf-8?B?K1NXM2tTQThuMi9GS2JlTkhEUW1tSFZkODJTR0hTYURKcU0zd2paR1dQTG1k?=
 =?utf-8?B?OXQ2L3BIYU9KZVBxaytRT1djeE93T0crWjd4TGhSRFM3dDU0eGxsSDFyY1VB?=
 =?utf-8?B?ajNlb25vOWI5MG9mV0xjUTU1RXA5VVYreUIrQWNGNnMzd00yblZQQVJ0TkdW?=
 =?utf-8?B?WkMyalczTVpEYXpDclVCc0pYd0l1dnZMQ3dDZWlhMWgzdTFoeUxFM1krc3pR?=
 =?utf-8?B?dzR6QzJ3WWM0NmEwRC93cWp6NWJNam9jN0RpdXpjdm45dGJFSkxKdEVIQWdY?=
 =?utf-8?B?UEVuR1ZBc055KzIrckltRWZ4TXp3R1U5RzNVaGdjbnc4c2kyTERLbHlJZVZF?=
 =?utf-8?B?bVVMQ1lCYnVKOGI4RVVYUlp6d3JQUmJvdTNZSDBlWHBjM2xRcEsrWWlTV3Rx?=
 =?utf-8?B?R25hQ2hLTUdLcmdWcmxqR25Qck02Q3p6NmZPNjdBeHlsZGViL253NDNkdWlD?=
 =?utf-8?B?TFE1bDVaRm9VSHpkbHBSRTY5SmxyOXpZS0JyN0dYL0N6U1E1cFBFV01HV0xl?=
 =?utf-8?B?SFZxWnV5UHNGdDBNVlUyZFZDSUkzUk1hSVowZGJST21ubEQ3VUVHZ0JUY1Rq?=
 =?utf-8?B?RXRucW1KTmJhUjF4UlBKbmM2QmpZRFY0Kzh5YVJ1Z3hOaUFDYllHcEwrY0ta?=
 =?utf-8?B?T2NTUDVUVkJHZ3pmc0x6cVJtekV6YWp6ejZoN0taWkdVSGdvSWYyRWplWFhZ?=
 =?utf-8?B?SmV4UHRaVVN5UWdGbWNnTnp6bURpSDE1Y2hnamFOc3BLcFJNMjdTVVhaeUpD?=
 =?utf-8?B?R3l1SDQwM2g3RTV6VXpTRkxmNTNid2FvRG5vOXVUZW1BUHZjdXE3MHZBZUhk?=
 =?utf-8?B?cnVtalZtVG94bUZzTkg3VmJ6TzZvRnZNVkY0Vk5aSmxZZENjLzVFaVZ3OWNB?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?amRZL1IyRHM4WVgxRHJxVlkxSUc2VFgzMXZSampjc200SFc4K2hqL0ZsWDlL?=
 =?utf-8?B?T2VGSU9wQWtLVWI2SGc4M1JjWFRCWUFVWlVZdW95Q1dGSXFnbkp6UTY1N09G?=
 =?utf-8?B?K2xCSENPS3NpLzQ5Zkd1NjZKbS9Hc0dpOXQzMUxkN0hIb09XUjEvQ0JCeHNG?=
 =?utf-8?B?NGJ2YThYVGI3a0x1UXlxL0NmQVBXZG0xRkFWWGh6akdjZlE5UmpXRnAxTXRp?=
 =?utf-8?B?REhQT2lwM0tSZWFHMUJUYjdlOTBYa3R0U3FEQWRxRUU5dU51ejhZNk1OVWty?=
 =?utf-8?B?VjFac29HcFp3cVE0YXFna3hoUXdIeFJONjluUEFSUExXbmtQdVNtZ3RFUE9v?=
 =?utf-8?B?cldTZCtpWTN3YkEzL0dpZEtjdS8xYUNVeEt6cVp1aHl5RVQrWW11bkZRcXln?=
 =?utf-8?B?RTlJVHgxcHExR0haQ1E0OHA5c1praWJXdnZxd29GRDRYcnp4OHZ3UHg4YXhk?=
 =?utf-8?B?TDU5bTNYays2SkRiODlFZyt3MjdVTmwwYjZSWHpDMHZtSFN4TUhPZ01zU052?=
 =?utf-8?B?ZFd3QklPL1hHTHh1NUNlK0VlNHZhSXB4OURoeDE3cUw4NmNEOFU1aVNzKzVa?=
 =?utf-8?B?WnVvbGFpV0xHa3pDTHdIek1ES09Bd0IydEpNYzdHckZrU3hhRUNiQzJlc3lv?=
 =?utf-8?B?b1ZrRFUxL3lYaUNEYjk5NDFwK2FvWThOZktHTUp4VnF2dmx1R2pSandDV2s0?=
 =?utf-8?B?WTRmQUM4Y1NVWDRLVVBKTWtrK3orTnlpUVQ5R3F1MXc5Sjk4Umh3R0tyZGJ3?=
 =?utf-8?B?dmR4c3N5K0dRTW91NWFoR0tvRmpSd2UzdjM0dm1HTVU3SmdnN0wxa0xSRzlw?=
 =?utf-8?B?b1pOS050c2VCRUhPZHhTeHNnQlROUisxRWcwcG0xd2VMRjF5MzQ1VHI3Z0F1?=
 =?utf-8?B?ekZXQnJIR2VJbGNRV0lPTUVEYXRBdDMxaUdVUjVzTmR1Uml6bW5QWXZheEJx?=
 =?utf-8?B?SnJkMUNGTUFzTWkwb0F5Ky9qZEd4bTBQMnBhYTBaRXd2UWFXQkVUTDJNL29k?=
 =?utf-8?B?OTNsNGlUQjAwOFczSk1PQ0Y0Yit2V3pWSS91NHRaV0VIZTRvSVNRd1lmWmlR?=
 =?utf-8?B?eVJCbFMwRk11RkxFeHpiaUo1elVJVFdRSm5LaUtSN0Z4L25HWnFFbTRZZ0dC?=
 =?utf-8?B?VjJobGNkcjRXRUlNS3hOWnprcFk1OUVBMHE3TG1VOGRrK0NoajR2NnAwWkZo?=
 =?utf-8?B?UlJmZy9KUTFCUU93VXVXQjZwaGlib2FPK1FVS05Qa0xKQmVkYkpqNHlRVkla?=
 =?utf-8?B?ZnBVNWZiUDRuc1lERGpiZGtwWTRmNklWNHQ1M3FHaVY5ME1ieE9jUHN1OFh2?=
 =?utf-8?Q?VPbNgvV4LEehX0ziZu61p1Tfp2DznDU9z4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dd9473-cb06-429a-c331-08dbb45cb58a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:24:07.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9rMqB/WcIjEy+ZBOv1bYpx4NyTAqmfGemxnUhKHa4edq9TphMMdy6yGRnjkMmjWgUR8Lypo1DSbXvES6kSNow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=491 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130109
X-Proofpoint-ORIG-GUID: 3yvJzm_LL0maK6HHZURuPVJRfYonJtoL
X-Proofpoint-GUID: 3yvJzm_LL0maK6HHZURuPVJRfYonJtoL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [230913 09:15]:
> Hi Paul,
>=20
> On Tue, Sep 12, 2023 at 12:00=E2=80=AFPM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > On Tue, Sep 12, 2023 at 10:34:44AM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Sep 12, 2023 at 10:30=E2=80=AFAM Paul E. McKenney <paulmck@ke=
rnel.org> wrote:
> > > > On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrote:
> > > > > On Tue, Sep 12, 2023 at 10:14=E2=80=AFAM Paul E. McKenney <paulmc=
k@kernel.org> wrote:
> > > > > > On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote=
:
> > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > > > > > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett w=
rote:
> > > > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > > > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howle=
tt wrote:
> > > > > > > > > > > (Adding Paul & Shanker to Cc list.. please see below =
for why)
> > > > > > > > > > >
> > > > > > > > > > > Apologies on the late response, I was away and have b=
een struggling to
> > > > > > > > > > > get a working PPC32 test environment.
> > > > > > > > > > >
> > > > > > > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 1=
2:42]:
> > > > > > > > > > > >     Hi Liam,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > > > > > > The current implementation of append may cause du=
plicate data and/or
> > > > > > > > > > > > > incorrect ranges to be returned to a reader durin=
g an update.  Although
> > > > > > > > > > > > > this has not been reported or seen, disable the a=
ppend write operation
> > > > > > > > > > > > > while the tree is in rcu mode out of an abundance=
 of caution.
> > > > > > > > > > >
> > > > > > > > > > > ...
> > > > > > > > > > > > >
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > > > > > RCU-related configs:
> > > > > > > > > > > >
> > > > > > > > > > > >     $ grep RCU .config
> > > > > > > > > > > >     # RCU Subsystem
> > > > > > > > > > > >     CONFIG_TINY_RCU=3Dy
> > > > > >
> > > > > > I must have been asleep last time I looked at this.  I was look=
ing at
> > > > > > Tree RCU.  Please accept my apologies for my lapse.  :-/
> > > > > >
> > > > > > However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I =
would
> > > > > > have said the same thing, albeit after looking at a lot less RC=
U code.
> > > > > >
> > > > > > TL;DR:
> > > > > >
> > > > > > 1.      Try making the __setup_irq() function's call to mutex_l=
ock()
> > > > > >         instead be as follows:
> > > > > >
> > > > > >         if (!mutex_trylock(&desc->request_mutex))
> > > > > >                 mutex_lock(&desc->request_mutex);
> > > > > >
> > > > > >         This might fail if __setup_irq() has other dependencies=
 on a
> > > > > >         fully operational scheduler.
> > > > > >
> > > > > > 2.      Move that ppc32 call to __setup_irq() much later, most =
definitely
> > > > > >         after interrupts have been enabled and the scheduler is=
 fully
> > > > > >         operational.  Invoking mutex_lock() before that time is=
 not a
> > > > > >         good idea.  ;-)
> > > > >
> > > > > There is no call to __setup_irq() from arch/powerpc/?
> > > >
> > > > Glad it is not just me, given that I didn't see a direct call, eith=
er.  So
> > > > later in this email, I asked Liam to put a WARN_ON_ONCE(irqs_disabl=
ed())
> > > > just before that mutex_lock() in __setup_irq().
> > > >
> > > > Either way, invoking mutex_lock() early in boot before interrupts h=
ave
> > > > been enabled is a bad idea.  ;-)
> > >
> > > I'll add that WARN_ON_ONCE() too, and will report back later today...
> >
> > Thank you, looking forward to hearing the outcome!
>=20
> On a typical arm32 system with global or architectured timer, I get:
>=20
> WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1587 __setup_irq+0xcc/0x6d0
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.6.0-rc1-shmobile-02354-g24e058b77f5a #1655
> Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x40/0x4c
>  dump_stack_lvl from __warn+0x78/0x10c
>  __warn from warn_slowpath_fmt+0x90/0x11c
>  warn_slowpath_fmt from __setup_irq+0xcc/0x6d0
>  __setup_irq from __request_percpu_irq+0xb8/0xd0
>  __request_percpu_irq from set_smp_ipi_range+0x88/0xdc
>  set_smp_ipi_range from gic_of_init+0x1a4/0x4d8
>  gic_of_init from of_irq_init+0x1f0/0x320
>  of_irq_init from init_IRQ+0x74/0x104
>  init_IRQ from start_kernel+0x360/0x5d0
>  start_kernel from 0x0
>=20
> Likewise on arm64 with architectured timer.
> But on these systems I do not see the issue I reported.
>=20
> On RISC-V:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1587 __setup_irq+0x4e6/0x5e=
e
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc1-02355-g63165363c6a3 #63
> Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> epc : __setup_irq+0x4e6/0x5ee
>  ra : __setup_irq+0x38/0x5ee
> epc : ffffffff80049472 ra : ffffffff80048fc4 sp : ffffffff81203cd0
>  gp : ffffffff812ee760 tp : ffffffff8120d5c0 t0 : ffffffd801854300
>  t1 : 0000000000000000 t2 : ffffffff81000ad8 s0 : ffffffff81203d20
>  s1 : ffffffd801855000 a0 : 0000000000000001 a1 : ffffffd801855000
>  a2 : ffffffd801854280 a3 : 0000000000000001 a4 : 0000000000000000
>  a5 : 0000000000000000 a6 : ffffffd801852108 a7 : ffffffd801852100
>  s2 : ffffffd801854280 s3 : 0000000000000005 s4 : ffffffff812c54c0
>  s5 : 0000000000000005 s6 : ffffffff80dd83a0 s7 : ffffffff805c0cc0
>  s8 : ffffffd801855018 s9 : 0000000000000000 s10: 0000000000000000
>  s11: 000000007bf638a0 t3 : 0000000000000000 t4 : 0000000000000002
>  t5 : ffffffff812882a0 t6 : 0000000000000001
> status: 0000000200000100 badaddr: 0000000000000000 cause: 000000000000000=
3
> [<ffffffff80049472>] __setup_irq+0x4e6/0x5ee
> [<ffffffff800497a8>] __request_percpu_irq+0x98/0xcc
> [<ffffffff8082501e>] riscv_timer_init_dt+0x186/0x22e
> [<ffffffff80824b62>] timer_probe+0x62/0xd2
> [<ffffffff80803c36>] time_init+0x86/0xa6
> [<ffffffff80800ae2>] start_kernel+0x436/0x618
> ---[ end trace 0000000000000000 ]---
>=20
> Also, no issue here.
>=20
> On the affected systems (RZ/A1 and RZ/A2), the WARN_ON_ONCE() did
> not trigger, until I applied Liam's patch ("init/main: Clear boot task
> idle flag"), which got rid of the "Interrupts were enabled early" warning=
,
> and now tells me, as expected:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/irq/manage.c:1587 __setup_irq+0xc8/0x654
> CPU: 0 PID: 0 Comm: swapper Not tainted
> 6.6.0-rc1-rskrza1-02357-g237e09fd64b8-dirty #829
> Hardware name: Generic R7S72100 (Flattened Device Tree)
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x24/0x3c
>  dump_stack_lvl from __warn+0x74/0xb8
>  __warn from warn_slowpath_fmt+0x78/0xb0
>  warn_slowpath_fmt from __setup_irq+0xc8/0x654
>  __setup_irq from request_threaded_irq+0xac/0x13c
>  request_threaded_irq from timer_of_init+0x238/0x2c8
>  timer_of_init from ostm_init+0x98/0x208
>  ostm_init from timer_probe+0x90/0xe4
>  timer_probe from start_kernel+0x2c0/0x488
>  start_kernel from 0x0
> ---[ end trace 0000000000000000 ]---
>=20
> However, Liam's patch causes lots of warnings on the other systems...
>=20

What patch?  The "init/main" patch?

What systems and what are they?

Thanks,
Liam
