Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524677A6A69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjISSHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjISSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:07:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FBA90;
        Tue, 19 Sep 2023 11:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfLMAts23qUQ5XJGj/k2rHZ7lWB02xwRJEF7ctcOZjVRxO+baofr4cLA/3JNh6hIHkkJEWPsxIveE9kWIaAwI4agjtUCqc6cvlhBRrc+n+OQ+eAenYT5dF5fQZWpUGjHag+H6dVqV0pXZP9ZnDO+pN/WWOzy3hMA+Evfpn9XS7rCgwNWJAWZzd60yel7ZvFfkP4z6LGdM/spEg4sSXlq/4IteMveUYHIKNWHpTDcWuzKupnIc1xzdJvSGpkxZ4EMZ9QYvF8oa3L/Z2dpactQRzF8TmwiG0a1Mu0IEO02zxA5FMDrFody8KNpAW9KOuBhFcqPETC29jB05d6SpeQUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtJnNaUn234lTJst1ctHzBdiKPlTyfUQbR09XRQxTiU=;
 b=dWDhv5uCDx5Nib/SrCze6nLFCX6ad76P33eghMoVNamLsWDuScOIsGVN/gL5Rr/PMiHJbdmEExl22CN4lwQmzGM/DLhZXS1kScmOJkr5tK3g+BKs+f3Nc3GspvYIt4VJ6hccSrZTID0gbXPTxzoP4UDjg9ZVkhNt2S4rbEPSdFPcjkpG/WVnb4XGBWdEUpfL6hGulxVbk9g2YxDo2v4W+0cO5aEpXNRWLHB0UOqWl0gccrUAlP9u60Q1r80apD73JEkZN+1U5dDLwFgC1t7/KYTi9bKoNBSU8Wui9JaBSJU6+TZH86McndA9Pp+xCMU4dzKxLWCSI3F9PZg10+qAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SJ0PR01MB7526.prod.exchangelabs.com (2603:10b6:a03:3db::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Tue, 19 Sep 2023 18:06:57 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::cbe6:1667:cce0:3485]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::cbe6:1667:cce0:3485%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 18:06:55 +0000
Message-ID: <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
Date:   Tue, 19 Sep 2023 11:06:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
Content-Language: en-US
To:     Steve French <smfrench@gmail.com>,
        Brian Pardy <brian.pardy@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Paulo Alcantara <pc@manguebit.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me>
 <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::21) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SJ0PR01MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 7444c840-38e4-4562-b94e-08dbb93b3570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyWaBIokrOGlUBNnIuPveEmgHXFf+k/JHkPmpo0ePm2Qa/kOJJi2cQOc4acvcHvsUrElk01lWHFPqfM+lZjJl1+MZD/BCiM3SCLFgZH5rsqLawHH2ark2DdUlCJYMQqiRf+6LJKXX7HT1otg7aoCqMQeROPutqpvzNwdF/c0L7FX2Rp8yW3TtoFLm+AvJrH/NwnK59NNS8ffDpbl/RAB7vrBtS2sgbAXpvV88T+3okrS0P0N4MucyfDDjAIuraB/CwA9ZHypMEzdoVVJAo4belbACQcftOetEdpaSbF5KAPNWTL6H7iy3TGE1YAWeTB8zxLM1MezHPlHSpbEXtPM9EuHevRRaNiNI30ZUW1BvGnLit0Uab76ePORXXKpUXu243/MCgKlxITzkMkFyattQqxRK2dCD0/6L5sOVviTa6+xHK+Ns1TOh4zj2E5l7t5+nI/VTckgmFTjoq5jNgepDyFG+yVRPtQnag4DR7XLBYRKOabk7njJm21NxFScXzBXDC7mfLiDXBU80DGF6mpZcG5Bs9lsrp+q7uiOWCtWRBxf/CDuRfWn6tsV3p98vCh1o25Klrzv5A1ESZc+/NB9SMYM7anDifgVF09hxh1kE2XSKSKg3X1QKjnurDqwVWVDmRFnuVM9Yzrdb8/di0tqtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39830400003)(376002)(136003)(451199024)(1800799009)(186009)(38100700002)(38350700002)(41300700001)(316002)(8676002)(8936002)(4326008)(6666004)(36756003)(478600001)(6512007)(53546011)(6486002)(52116002)(26005)(2616005)(83380400001)(66946007)(110136005)(66556008)(54906003)(66476007)(6506007)(2906002)(31686004)(5660300002)(86362001)(31696002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhEWWsyMnhvV2VsRmdUYkpoL0Jrc2tnVFQ2L0ZzZnZ3OG1CdmNGZGdVbFhN?=
 =?utf-8?B?WnVhczhOYWVLSHZRalhQUGR4WmluRjY1dm9YSHhJeHBtTE1mRU8rb2ljVmY3?=
 =?utf-8?B?bFE4VDMzUUZSQ3RwbmVudmh2THVualhNczYyd1ZENk4wT1R0aXlUZTNjdGhV?=
 =?utf-8?B?aGI5Kzl4akhiS1ZRQTNhSFpnMjVXdFFySSs0dmxjQ3lVbW9BNGJvZnBxN1hT?=
 =?utf-8?B?N3pvREVDOUVLdkdWTHErY2J3Wk9MUmdXd2dYeXRVeFNOZ2NKTlRxcmZSbjd0?=
 =?utf-8?B?QnRSVnRIWEJxN3JqWG5Nb0hNcU1Kcis5NTZIcE1ERk5iTmFXYzhlelpadDRP?=
 =?utf-8?B?SlgwSjVEai9GaCtrek9jTUhYLzNJcG9EMzZEY0hLY3RMdVZrZUo0ZmZGMXN1?=
 =?utf-8?B?OFJCWDkvWm5DMEwvYWlRSDRyQnFXdThXT05jWXQybDFMTTBnV2tyY2JsSDd3?=
 =?utf-8?B?QUpNRFJTK2IycXlrZVRhZnNsVkozZktoNUFJcXF3UnNMZ1VRY1NwWDB6SkJ1?=
 =?utf-8?B?MDZuUmRnbWJka0dwTHdNUUloRnZzOTFxUHNyVWpmcmQ1SFBXcU5rRU1NMit4?=
 =?utf-8?B?dFZncDhndjh6bm5zb1lpbWNKdW9LRU92THQrRTEvU3JmcnlQTHdXdUM4ME5H?=
 =?utf-8?B?engraG90dkY2c0hoL1FHMTVwZTdWQzlsMGkrNVpLVlpZVDRoN3dOeTA2dzV0?=
 =?utf-8?B?S1VKNDBuZGRrVTdKL3dHS1ZpRk15clQyMkszN2tmcVo0TVJhLytMaE8ycXhu?=
 =?utf-8?B?MVNEYmY4SkhQSk1vTTVOeU1vYzdXdE1JU0ZFZFpLalMwOWJFZ1pNUTNSNHF5?=
 =?utf-8?B?dS85cGJMa3BQaE1ndU0wVE5FUWVEUGoveTRIME03ZGJzb0hObkdCNzlURG44?=
 =?utf-8?B?TU9jV05Qa01RZlRXVnFHdmxzc2JMZ0wyZVkzdFJiQ3JGUkFWc2Z2MWJHTXVW?=
 =?utf-8?B?ZnhMNTQ4dzB0ZXlXR0dNcDQ4Z3FyUFBDZUFIUmlsWXR0MXgwQkNvRFpkb0dk?=
 =?utf-8?B?bjJKK1U5UStLZjFGMlFYK25JRDhqSktFRklmakR6UzNyMzdtUHY3UUtYME0r?=
 =?utf-8?B?NjdnNk50dzEwMUJmS1Z6RGoxQUtOVytqZjhWR0V1TW1UK1lEbE12MTh1b1pt?=
 =?utf-8?B?K1JZV0NDckZlY2hkNWNxdWpTMjJkZVdCZ2k4UWJseFBlNGM3cDNuNWdDOEtp?=
 =?utf-8?B?cFg2dGF5a1FRYWZaY21ScGlkOGQ3YUtGQnNiczV3UFozeDlxSTBOSGlrOS9B?=
 =?utf-8?B?OGtNWlNXZWM1RmdFc3FHZitwQllvdUhlUnNIdmxCb21tVjZtckFXS1VXOHpq?=
 =?utf-8?B?VkI1MU9NdCtKQ3VFZndURGtkRWxuVWNieW8vQ1V5ZGp2Q3hGTXBDWTFpeFYw?=
 =?utf-8?B?a3YreVpHT2xiYjdaVDNOeXBRSW9RNFJPSkpORDROU2tZREt5UE1Pa05mTTZu?=
 =?utf-8?B?QUtMZGdDUkRaOHdFR3Rnc05UcUF4M2psRjd6VXBDcURGb1dSRW5mUmp5VStG?=
 =?utf-8?B?QUZSRXFrQ0Z2Yk1ZOXVaMFIyMll3YmVibE82eFZLQ0JxMmpaT2dYMUhnY0Iv?=
 =?utf-8?B?RjI5T2oxZk5vY2tzRm1wZFJvWGVaRDNWTmRaak1xVzh3R3FqRTlkM0dMVSsr?=
 =?utf-8?B?bGYwaXRWcDVrL2dpdXZPUlc4dGlzaVZKQktmWUppbC9NbW9mNEdiU1NxSFJa?=
 =?utf-8?B?QTNpOTg1WDZvL1F0NTVZczV2cTBtMkNUNUM2ZjZ4VjZaOGt3blI4TjJtQ3or?=
 =?utf-8?B?L1VjZ0g0VEhzMkhtaXJKcmk5N3pqWDd4N25FUVdHOE9yby9NU3BWbndtOXY2?=
 =?utf-8?B?ZU41ckVoTkplaVRQVXJpbWRkbEVHazZWb2g1WXdvcE4rSFh5NWthOUt1NWUw?=
 =?utf-8?B?OVU0K1BFcjl5N3BWY2Vacmg2N2hKVXlCOENjRTRTSmpxdnNTSTlEV0NyT3U0?=
 =?utf-8?B?R1dvS0VodFJvRjIvM0pSRWN1RHhnR2Zwbm9oL2pxYlpGZnhjdEJJNWtIWENj?=
 =?utf-8?B?NGQ5QnpHblY2SVJDdVFPUnFmb09aakRyK2ZFSHN6bFQyLzl0MUhCU04wZFM4?=
 =?utf-8?B?azUzaTJ6UlFuU2VZM3A5NkRvSlB1Z2Y1MkpxVGdXRTdHQUJuZ3N2d1NYNzNz?=
 =?utf-8?Q?uHjGIFdy3pFmD0tDOdCNJJbRU?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7444c840-38e4-4562-b94e-08dbb93b3570
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 18:06:55.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYuF+pdauPot5PMWb1197TlwNHEYJgo1f7tJBz6oGgMA2Q/RSdIKbDlWOCsGYdAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7526
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2023 9:38 AM, Steve French wrote:
> Minor updates (pointed out by Paulo) to patch. See attached.

So, was the thread crashing before??

+	if (cfids == NULL)
+		return;
+
  	spin_lock(&cfids->cfid_list_lock);


This if/else, IMO...

@@ -2492,7 +2493,10 @@ cifs_get_tcon(struct cifs_ses *ses, struct 
smb3_fs_context *ctx)
  		goto out_fail;
  	}

-	tcon = tconInfoAlloc();
+	if (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING)
+		tcon = tcon_info_alloc(true);
+	else
+		tcon = tcon_info_alloc(false);

would be more readable as...

	tcon = tcon_info_alloc(ses->server->capabilities & 
SMB2_GLOBAL_CAP_DIRECTORY_LEASING != 0);


These changes are good, but I'm skeptical they will reduce the load
when the laundromat thread is actually running. All these do is avoid 
creating it when not necessary, right?

Acked-by: Tom Talpey <tom@talpey.com>

Tom.


> 
> On Tue, Sep 19, 2023 at 8:21 AM Brian Pardy <brian.pardy@gmail.com> wrote:
>>
>> On Tue, Sep 19, 2023 at 1:36 AM Steve French <smfrench@gmail.com> wrote:
>>>
>>> Does the attached patch help in your case?  It avoids starting the
>>> laundromat thread for IPC shares (which cuts the number of the threads
>>> in half for many cases) and also avoids starting them if the server
>>> does not support directory leases (e.g. if Samba server instead of
>>> Windows server).
>>
>> Hello,
>>
>> I applied the 0001-smb3-do-not-start-laundromat-thread-when-dir-leases-.patch
>> you provided against the 6.5.3 kernel.
>>
>> I can confirm that it resolves this issue - no laundromat threads are
>> created, and the reported load average is as expected, not falsely
>> high.
>>
>> This appears to fully fix the issue in my case.  Thank you very much!
>>
>>> On Mon, Sep 18, 2023 at 10:00 PM Steve French <smfrench@gmail.com> wrote:
>>>>
>>>> Paulo and I were discussing the laundromat thread at the SMB3.1.1 test
>>>> event (at SDC this week) which is now going on - will let you know
>>>> what we find.
>>>>
>>>> One obvious thing is that it probably isn't necessary for cases when
>>>> the server does not support directory leases, but we noticed another
>>>> problem as well.
> 
> 
> 
