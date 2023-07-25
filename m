Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0F760C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjGYHuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjGYHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:49:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A4D3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6nwFXTYzhMNzMK3ma1RLmzC04E+/o2rz5wWzWi5ApQ1TErhpn6bCmg5cwSUIIrGpwoziUEslZvp3ph/V5dNmHO/UbhE6iJ+JM93rEGeErR6C3JJks1meLLl85UniWE3oCJcwgxCDO3nsVbBD+M/hnJEXiFbbdp0cvw+634WGMmMZrm3g6MbEhWsHFMLDyOKKFFmZifG/GMMF3BUWZ7PS0gVJ9rqbLKkdM7nfhPtX1V/HHorBGiikjdQvoMNKfGqEuaTHk7pjU3UWlaGXKkPCXFpvYasi54+GaibhCErUns8OQ1moqfcbhbtn+nRW9jNxwvuez6JT+sxrdEIQgp+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnV2Wz9VIuWc6O3b1FpCA0oPWzq8AyxfKwpDVwjvO08=;
 b=CPYKuu34QIteLKvGDNuZ5mZbiL6IILt1A1H8US+3kZwjBz20xdRCVoS0YBM/SQCI4uuxx0cj+ioHmONoLS3ophK3/3ixC2RE9i15RvSBe9roLsbXR/RvF9j02i5hIw0rjhpGbDdSVqOY/Duhk5p/cGzpt3rlbvn+WcyN7nVGVb2Pcs9L3MC59x/OBciTorxhvvlA9ym89NcRLXuy4HZS6EnShyrEsn1tCEdv/ZBVsZ2ErpEWc6sL/JBFlWvwJlckA29PsNuL6yIqrq3VsxtStWUvKzLdQihSyHG6+WL1Qz84Dv4bq6fJuy/phOigxbwJDYhsKPfJGIDInCseLftZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnV2Wz9VIuWc6O3b1FpCA0oPWzq8AyxfKwpDVwjvO08=;
 b=i5h3KsnPQgHR04TDXXWr2NPWj87Pbyo9XMX0s7arlaTDDVTeeeGTwj7z6fHwiyl7gX7IcQlUDt8KUhFNVYCX/IoEkPv7dYOETEkOm/j1SOkQ3WJRE1kT5fckiA9JEnyF1zbr1ASsW/43jPYaSzg7N5m4bAe/Ufi9n365xXDEKLIxC9llEOx2lBGBigTEXnWk1rAJ/1AhDs8I2vUFiHu7eo6YMD8PVJMNG/6SG8gXVHmy84s4mvpvBYLxB04UBdp6VYOqsDegXFbk0oV6oC9dCny8aNXAn7tSRDox9Jfn/GsnQxDaT/vWhLOP60n1k61GPG99EU2JKdyqKZGcWjiiqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23)
 by AS5PR04MB9942.eurprd04.prod.outlook.com (2603:10a6:20b:67e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:49:53 +0000
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::e5cf:5743:ab60:b14e]) by DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::e5cf:5743:ab60:b14e%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:49:53 +0000
Message-ID: <920ede72-c2fb-c814-7b1c-aa488e400f83@suse.com>
Date:   Tue, 25 Jul 2023 09:49:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 1/2] xen: Update dm_op.h from Xen public header
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
 <1498bef6-ded0-1b1f-a5ca-e8755800b489@suse.com>
 <20230725070914.m3dxlokedrgjlgcu@vireshk-i7>
 <3770f13f-0621-48af-4c79-880a0ffaa8a6@suse.com>
 <20230725074218.zcgbkkx5pfgszimu@vireshk-i7>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20230725074218.zcgbkkx5pfgszimu@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To DU2PR04MB8790.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8790:EE_|AS5PR04MB9942:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9911ab-333b-4380-3d6f-08db8ce3bb94
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zve+le0WNiHuJSnhrzEJN+6PLckPQ7h75e/Uvk2jSn+bb9c9Ig8omN/OxYzGE3pJnxnPUYUjWLEzk4PTzLG9kJ2ca2ZpI1mJ1aQUdIXPNEPWnbSkPGQGl00MrDgH6UcXRoDb8n8c5OT5BBmMiU43ZitqBfHjmbOTYYZlVnsorPevHduuDMOd/0gSumLT7E/BlP5o4c0khER8Hj8kBTdkqSIQAbCZNr8G0by7Lb2xqtuFDnuAeHAz7WDPkkbEG2z3D3Z7d3cR9yrir7TMqP8Aj6GMEWYwUQDoEWTSfBAZ3su+L34s+KCTLFFsfzDRLsATAsWLneOQWsgZ9MAbKe+Pq6uhgSEUdAGuRkfGtTNn3rucR52ZUIytnU0fJrQNhfAfhx6/zjGI1YKFGwI99hLsJ4HiG8/aFEnTbZIKl9nhAXVfNbf3XOAQbFZOKoX+oJaXKc6ZgnrlCZl9P89nwI0YUInLcgScARWVyUepaQdJP21x7DZb5MEVH8ntE8gn2SYxLd5pOpe+AnGljUVBWBJM7uDDu46cHofsL2oWzAKN9D0wV2uYNqO2PqFafuqU3bT2Pw7egjVNY7YJzvkPmosXJZmE/xH7/YPfxoRE1DlxL95bbvHg7AA9Zog33/UPHf6Dy4DoC21M2OPUyQ6q8s/LqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(54906003)(66946007)(66556008)(66476007)(2616005)(36756003)(86362001)(31696002)(38100700002)(478600001)(186003)(6486002)(6512007)(53546011)(26005)(6506007)(2906002)(31686004)(41300700001)(5660300002)(316002)(4744005)(6916009)(4326008)(8676002)(8936002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXF3Z1hNeEpOYytZSm0wSVM5NlhTRXJTRWR3RXZTQ0xQZ0M0QWRtNERLQTdS?=
 =?utf-8?B?dThJb3h5MkU0bUJCQlJ3c0lraEt2TVVKZm5rRDdFd1RtSTg2M0tMYUsyNkds?=
 =?utf-8?B?ZkRNeEFaSG1WdFhBVkpVN3Vsd1RNemZjUStzV1BnYjA4WFRQbWdLSGtxTlhU?=
 =?utf-8?B?K2JSZGI4cklFdm1HV0RYQ0lSaCs1aG5ySGRTQiszQlBhVGR5Wml6QTBJQmdy?=
 =?utf-8?B?QiszRFE1SE8zRlJhekFTRzdpMmpmUzNJV1JWUFBZT25OZXdMenY2K0ZuVHhk?=
 =?utf-8?B?MXBjOTEyOEVOUlJFUmpRQitNRmVVTTFocEJxSWQ0VU5DRCt3RStLQW1iSlAy?=
 =?utf-8?B?bDhFZ1VEUUZZV0NONS8xeXY0Zkc2VzZWb3FVNWk3NEJBREljV1loUERKelpt?=
 =?utf-8?B?M3JTVGszNDZUTW5aVEl4TGQyZ0p1MWRqTlRuWjNnVWZ4U3VVYVhEVTNPb3FG?=
 =?utf-8?B?ZlpGbVpoZzk0Uys2R3J5S2Y0UENKZXJmazllMmkzVWNwekpGSVVaMFVUc3JV?=
 =?utf-8?B?STRXK3EwQXJzVHMxdDYzNFE4WDRZd3NyaTE2Tmk1a3Zzay9SZ1gvMUQvRUdQ?=
 =?utf-8?B?MThiRytVbjVXeUREYUd0ZldxQUY5Q0U4V01YY2p3d3VVVHhTNG5USGd0aFBu?=
 =?utf-8?B?SXVHTTBiNkxJL1UvRTVlWnYyVUhmSXVqZDh5WWZXd0V5cERweFVjaFpRbUZu?=
 =?utf-8?B?TnYzYUJyMTFWZFRCckt4enhqcFhIMWFMazJnZUM1ZVcyM2NnTXRQSGRsTzhp?=
 =?utf-8?B?SzNSYzI4d3crdzlzekpIK2orNGxXUnRBczBWYlc0UTh0RU1yZ0ZaK0o4cUNK?=
 =?utf-8?B?QWlHQXlJdXdQbVhzUnBFUlNJVW9tQW1xY091b3JtN3I0c1FRVEI4ZkkvU1c3?=
 =?utf-8?B?VW5jc3JrV0VQMTFsRGFpWm40UGNUNndBZ09hZ0NML2VNbWJSOEZadzFLZkhu?=
 =?utf-8?B?UXR1Wm9FSFZMQ2xJb3BGU2lsQTdUeG1xbDY4WE02eUg1QjE2dGFCQW5hd054?=
 =?utf-8?B?MkF4WE8rV1JWdTZKQldYQTJPT3FXempzRFhhemROTDlGeFZwS1ZsRDJocXU0?=
 =?utf-8?B?cTM2MXpLZzRUb2NuMFg2SU9mbExxb2hOcnRsVExjSXdoRXdrZW1FTm50dkE4?=
 =?utf-8?B?ZnV5WHNzcjhXei9keVhYSERWWUxmbWtZZzVxVmtoTnp0TmNSNm5RczJQTEE2?=
 =?utf-8?B?dEJMT09kSmNTU1VxdjBwNEJVUG8zQXErZDFrdzZHS2kvN0pjVFZNc3ZScW1O?=
 =?utf-8?B?WkRPaEVHbGkyR3VnK1VMMzdEa0JmTWZBVGRobnNmOFJkcVQxbEhERkVxSnhN?=
 =?utf-8?B?MVhVMG1LNlgxd2xhTENqVmdqVVd5ZHlFc1Z0RllKK1kwcm5SZWVUeWxNUjhO?=
 =?utf-8?B?TTY4YllOOCtXaW9TTG5rRXJRRmdtYzliTTFhdWhJcGZhS3Z0ZWVSWWFraTRl?=
 =?utf-8?B?N3MvKytJNVRSZ1VoS1ZYK0l6d25lSWpILzltb1dpQnBaeTFCWFFJL0JTbURj?=
 =?utf-8?B?MDlMWDdFamFFUzFSdzhvSlQ3dTZGaFFBMXNkUCtMRkVoWnJPY1R1TG12NWFY?=
 =?utf-8?B?ejE0MDkwZC80eG53RTZVY1c0UjVwZkRXdUVHQ0lqYXoxcWdrR2FFY3N1bStl?=
 =?utf-8?B?VHNOa0tOS3FwNytTMlZCYm1uOGg2S0VoWjBYNmdmSlJYMERpdnRxOFd2d2FQ?=
 =?utf-8?B?ZDZHLzVGLzhwTmNHdjIxOXN3OFF3eDhMSEl6Y0p3N0F0MDdvUmNsaTd4aWFD?=
 =?utf-8?B?d3VWalRUM1lxa21DeG9FbmdObU1nV3JuUTk5QmhOSG9oejR1TnhkQ2N0WjFF?=
 =?utf-8?B?SW9OK3FWWVVFckZUc0JleGRqbmNsbzBDcDAwcFJMSjQ5ME5VNklPOTZZdm9a?=
 =?utf-8?B?Wlk1Syt5NFlUeTVSQXJzZ1ZKVHNkZ1UrMWFzUGd6Y0dVR0ZOWDMyZGVQNEdN?=
 =?utf-8?B?N0gzMGc1bHF3cjdFWnB6cWhQMmM3OUxlMWJIaE56NFp5KzdqVmwxbUJxOVNL?=
 =?utf-8?B?ekZEQ2ZoZDF5TUFqZDRzYS82NmUzUUR4UUd1WkZVMFFwUUZEVWhmWCt2M1Ji?=
 =?utf-8?B?OStDUEFGYm93N08yWkRlTitrZTlrUmQ4SDEwcDYwZ0lFSmlnaDJFZ01tOXFG?=
 =?utf-8?Q?yDASf07IwxwFY9EwKwhHn+Plf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9911ab-333b-4380-3d6f-08db8ce3bb94
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:49:53.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zxKfk0H1aK9mMTdEApZvO1rQ4495PPR1+i4Ogddnicx4jiNVeld2xOcBhbTO6BWDW1L2iKtl+btb5r9T0P9IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9942
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.2023 09:42, Viresh Kumar wrote:
> On 25-07-23, 09:18, Jan Beulich wrote:
>> I question that use, btw, but it is not up to me to decide whether to
>> accept such a layering violation in Linux. dm-op is, as its name says,
>> for device models to use. Your intended use doesn't fall in that
>> category, aiui. Imo the present contents of dm_op.h in Linux is indeed
>> all a kernel is supposed to know about, unless it was to gain in-kernel
>> device models.
> 
> Is there any other way by which an interrupt can be raised for the
> guest VM ? I was only aware of this method and so implemented it like
> this.
> 
> I am open to suggestions on this.

Well. I don't know your requirements. Generally I would suggest using
event channels, not interrupts, when talking about injecting events
into guests. If it strictly needs to be an interrupt, then I guess a
non-dm-op means would need introducing if none already exists.

Jan
