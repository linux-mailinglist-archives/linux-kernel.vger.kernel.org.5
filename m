Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDE7D99A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbjJ0NVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345825AbjJ0NVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:21:39 -0400
Received: from outbound-ip160b.ess.barracuda.com (outbound-ip160b.ess.barracuda.com [209.222.82.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B46C2;
        Fri, 27 Oct 2023 06:21:31 -0700 (PDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169]) by mx-outbound19-87.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 27 Oct 2023 13:21:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuPQxzG2OE51PZp6InpDW8Yz4EmIMa5/HhT7gIdUpa6Q9vuVm47y4yGgh/Yhlr7WcreqGGzB++ELo7mh7/ysvqv60aB2iMACGzJQtNczZyWjxHBsNmGhstq7ZKFZ5MnEbP0sMWbM4+yR+wR6DNia4Nd9F7mVjOg1lgKOI9kG4wwX4FKY/WDmWXr/ezTJTqsEzgZLGVl5pdByTHqfICNriINjS63H2NNfZuoRFnRWO6EQDiHpdde2jDbMqle17CICmysaO/nuJD0qkPtaXs7jX9wvcXV0RBQl8SUsK+7CsC5yTUjd6D4fvcWMcyGa33G571Rm5VsDZNeMYW6jHtqfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNJzENrWdv7X6bJty1vDWv9RuwkY/u1AUl1pO18akmk=;
 b=kR9Fqxf/bvS8YW22odWQdVBtqLaei52OcylduDWcb6rgWR25ZcvrZ195f4h+WopBXxTsBebZ8ckNDKMX0P4xCjeAa1rJA32/Bk532Gx5UyYV3x9kgP/ekOCSRAfbtA+rCPoHhjr/pHnrZxag3/8YoLO4Gnb+ZcbFnO9xyjTtSYt833GxjJ1ezPnb+17GKJKVAgskMov8/BY6H/4kDZL9zEQ/d3oY2NWKZq+4+/xuknnX5GnS0SEfpq7eo2aNJfm2zBpltjjOa63YfS2P6Xv7ygCK17ABv0vqApvpk7GVrPwxfhFj1peBolsce4rRPt2UkPab1EmRrp0Qe/paXCL4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNJzENrWdv7X6bJty1vDWv9RuwkY/u1AUl1pO18akmk=;
 b=vq69i6rQ8OYmCzcYJwLbbgUGH7zUX9T3eOph2iFB9DykO7sQ97vGNvq6NyED0Mie4WKWYJoGJyEXeCzT0YGkuECseIIq8GWBOth7LRnOokmwR7+Eqg9MTFzwYZE05ni3ACxW4JMv6fFqnF35u8QRr1T8RQHGWX6RvXbItkkcml0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by SA1PR19MB6792.namprd19.prod.outlook.com (2603:10b6:806:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 13:21:19 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::74ca:a803:412c:fcb3]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::74ca:a803:412c:fcb3%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 13:21:18 +0000
Message-ID: <3a7b0345-7a74-42ad-bce9-fea52ccf7ee2@ddn.com>
Date:   Fri, 27 Oct 2023 15:20:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT"
Content-Language: en-US, de-DE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
 <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
 <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
 <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
 <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh>
 <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh>
From:   Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <2023102740-think-hatless-ab87@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::13) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2037:EE_|SA1PR19MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dee115-ae5b-4d8c-a04a-08dbd6ef8f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJICB80D2WihPxo0rlqhoUFplxv9MKfPXs4/x3CNhPzKqlJHALi3f3bCQTYB9sCSswRZ/Rs2gp6rfYCE20KNKaJEmfye4q6R1APuhWzrojJ6Zv5Us19Mq4nskmhSM/NyVgnmXtDx4mAQb+2ODqE5LclgPvYOc3RUT2DlTB3wYqCbr4nXhrriyr7eSKqclCqi/HZcRGSXMXZxSpzkaRycMV+3kt15cQTZUyn/LP5TDbgNdnuz6jgRQuuraQ2SlNjScsY8uu2w+w2mE2VCtdrRiqjZf/4SJE7fIZnSpwYqDapJk8Z13uwVbH22E2hsXvVllpS0foik855R1wLEq9ywAAWwYe/pAiDKK/EsuaOLb85PweyN6wcIcJ/1xtr2FvWu4l9vdmipGzk0WUowc7fx1/U37Uun9ehiai3N3FhQf2tsEBrcLKPGVHYmt6qVCDJjfALwdgVwc4YmVTyb/JLttN0MxwdvkegLsH6rtQjVEBit0GJIwz3DASqu7b7pU1/2gNmWilGTeaslOQhgf8d6E7UU7SlXKTiQh7DyIQZTjvq8+whFZyDKl6d1QhdePzfmfHHtYavkm9Y0Wdir+JpzNfl40bABPB5Amvmvdi3K/GpWu1N27ecvDOnBn8e11tapp63YPYk8U8ZZ1tC53DQp9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(6666004)(6506007)(6512007)(53546011)(6486002)(478600001)(316002)(110136005)(66946007)(66556008)(54906003)(66476007)(36756003)(86362001)(31686004)(38100700002)(2616005)(31696002)(8936002)(4326008)(41300700001)(8676002)(7416002)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJvR3NwdGV3WE5UcHBuckVFcy9CaWRlamc4TEZGb2pDZE90UE5iZ05HU0Vh?=
 =?utf-8?B?TWNHTW5qbkcxcytLRkpUNHBmVHlIYk5oMkRkdmhUZUY2SzZVN1g3RzhXK1JF?=
 =?utf-8?B?dzhBRmgva1hFckpmaDZ1R2lMRnFTRTN5bDU5KzJuTTZ2TTZpbXdPdkJpZWsz?=
 =?utf-8?B?RXY0clJDdVd6bFdscjlKVmkyM0FISGIvY3NZNU45L3ZMcmdUQ1pvd1BYWUJQ?=
 =?utf-8?B?NS9ubHBXTGNrU09xckZuaGZWbEo5Wk1IMEgwK0RJVkxTSWI1YXl0MDF2MUFx?=
 =?utf-8?B?YnpNUTJCREsvNEpJbGtnV3BWbUh2UFF0VHlaN0lIYlhSTmltaFBHZFVIRkM2?=
 =?utf-8?B?ZS9vRTI0cHdabXVDQ0dYSTlwZ0lMUHpEdUpZTlg3ajBtNS9Ib3RTRWZHcmlI?=
 =?utf-8?B?MkxLUTl1MlVFZXFYVmZnYmEyc3o0LzNkUFZkSG52azZRTWhmemdIVXg5V09x?=
 =?utf-8?B?WW0yRWFwS0Zib2U5K2E0V1grNnIwTEQ2d0JTRE9XZUwxR0U1WkRYTTJPa2Fu?=
 =?utf-8?B?dFZ2UDZaV0VwTmtGbHNmdFhDWUtwZytMem9IcDRqcnFOajVOREp6OUUvZzAv?=
 =?utf-8?B?eHVPTi91a1l6bjcvVk5UeENMRDN5eHhyUU9pZHBCK0ZpNEtTZUZqUUFObG51?=
 =?utf-8?B?cVlzVGVaOGN4bU9FakQ3Tm5PQWxENDVvbmdqUDBLVlZTalE3QURkTFI5cEtU?=
 =?utf-8?B?UlphTzFBWnMzb0ZDazJQWDJCVEppdkY5WmVWMlhYUmpwaXY4Z2cwWGVMNlZ5?=
 =?utf-8?B?RGY1WWYyK2E1ckFvdjdaQlhiM243aE5oWVlBTUMrZFByZHJKZWFLSzl3bUlQ?=
 =?utf-8?B?c0JSYnpYVUlqWUQ2KzVJUXg5MjBYUkNFY1doNitRVWIxbk9zaXhuVUhpSGIx?=
 =?utf-8?B?OXp3RDBiR3UrVzJZQXUrUFZPaTA1MHYvTnpSaSswQTZ6TVhIYWxBNmJySGxQ?=
 =?utf-8?B?Zk9QYzZaWlgvYnNSU2ZkR0hmME5Md0RxVFFJUjdNQWZTbFV1VmpjV1JLenhr?=
 =?utf-8?B?UHNTRW1RRlFFTXJWNDlwYTAraWFoN1lhRFlwM0FxYTN4UDljazh0c1dBdFE4?=
 =?utf-8?B?aldBNzJjcS9iN3d6YXl2cm9QbHNEMG9YRDNmTE5OOXNGN05LTWxYenNweVRZ?=
 =?utf-8?B?dGdhZFZvbk82cHMzVloyUkNjUVNXODdITlB5ZHhzY0kwdXBJV01scDQ4VGtO?=
 =?utf-8?B?S0IvWXRwN1NJWC9tR24zZ0JQUjVaWTF1QU5ZQ1ZlUzBmR0dsdzgxeVRkR1k1?=
 =?utf-8?B?M3RoalhmY1h1bktYQW8yOGhjTm5mTU5JYWlqanAzS2dLZkVXSkhMaEdFSXF6?=
 =?utf-8?B?c1FDMTd3eFdVWGRXTVBpTWh3aXlla3NUVC9JOEdhQlRzcGlocTVmNVhHY1k3?=
 =?utf-8?B?Y00wNHE5SmFTOFRabjRCcldHZ3VEbDJmOERQRUljZjhjQUp3REhoV3Ivb2s3?=
 =?utf-8?B?Qk9oSnA2a0t3UGpLZC9hbWJ0b1BFcTk2TW5QTDI1cVYzVjVxd01PcGtRSDZr?=
 =?utf-8?B?RmZIazhVL250eWJ0K3VzMmJaQU5mNCtrZ3EzQUgwNnArTUlLaUtVNjFiL0Nl?=
 =?utf-8?B?bFZid3hFU3RPbjJRaWJoeFpHUGcwUnlPUEdLbjRZN25OVlU1RkdCenhsRHg4?=
 =?utf-8?B?Vjh6UXJDSTRNVHZNbTVqbi9sT1hsRjQvODhBRE4wUkFwaG94RFhReTlqc2lY?=
 =?utf-8?B?dWdHUDFEdEM0ZHJ1NzRWODdNOTdnOWU2cVp6UUU3dXJDZk5mVHV2YjhOc0Jt?=
 =?utf-8?B?L1JWSzdaR09HTjNuTjJtNVZBaURTWmt5ckhxRjFEZXQ1MW9LZjRjd2RRQmEw?=
 =?utf-8?B?V2hwL3pNQjlpTkswaVpEQk5FWVN1RHByemo0bktKWVhzeTJ2Tzd2Um1uaGV4?=
 =?utf-8?B?VDVCSm9qQUs3YjAyWGZISkdrU1NLZ2I3Z3R3YzBMRTZNOXQ1QkxiWi9EQUo3?=
 =?utf-8?B?VFdXWHBDWWVpaEx2TE00dHpMeWVNS1JEQ3NFNlZEaWd5Rko4VEV6cmluMGNB?=
 =?utf-8?B?SGVZODFlWnNTVzdUdGdkSUZMK1JFT3YxZzVBTjBlMjFVbXJ4NTFpTWJUS0Iv?=
 =?utf-8?B?WWM5UktpeG9wSENWdHNLNjNHRHVuN0I2cmhJWEFlNG1FSWY0bDM5V3Arc1dv?=
 =?utf-8?B?M0p4V3lHSE84cHNPWkpoSmVpOWt0V3k5NkIvOFIxNGt6dHRLK3RtY0J0eXgv?=
 =?utf-8?Q?vtdgvt9WQg//0t7mlJSKagbPPJjyTwhjnGnfRicFCkao?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d3AwNWhtOWdGanV2c3R2WS9XS0Z2Sm1YWFl4UXA5OVhWaHhFUUY5Zml0UVZQ?=
 =?utf-8?B?Y0pjU1UwWHhYc1Y0SU42ZU11cFkvYkN1UVkwU1h3clIwOXlheXRjNWdBVk81?=
 =?utf-8?B?VWtGUGNXOW1UVDBJNFFKTzNmQitxa1pydUN5VDM2QXRTSkJ0aWFnNXFDcjYx?=
 =?utf-8?B?d2Q1ZnkyK2dTdll5VVV4bCt0TUZQUERJaUdabWhCb0UyS3FLSnBiYi9JWElB?=
 =?utf-8?B?bW1xeEpSTEJuZnp0enBmWndiemMrYlJZTk55ZmR6ek82Z0YzS0E2enJoMVZj?=
 =?utf-8?B?UXFWWFhsOTlwVVpaakQ5L3lOdEYrbmdWRGJHd1FGQ3NMQmMvNFZoZ25vcHRh?=
 =?utf-8?B?b2hGY1h1am5ub25jN1RTbU1zVzV5VWZuYWNhbVIrc2ZVeHJVZTcwbTBjZXRk?=
 =?utf-8?B?K3puaGlKWmdMR0FLK21xMGQ5OFY1ZUFZc1cwWEJBUy9WV0x1QkJZd3JmTGdp?=
 =?utf-8?B?eVEwcEFncW1aUWo3cHBUQVJ1elBQeXMwWHEvTkF1bDVTVG1RWnRhWEVhQ1pT?=
 =?utf-8?B?eTBwM1dPMWd6VjdhT3VuS01uWEw2aTI1akoyUWVXT2daWWo0YjU1d3EyaHB5?=
 =?utf-8?B?WERjM1NlWjN4bWowNlJwMFhGQWpGVHN1a0dGZ0ZuM01UVHNIOHhDZ0sxWU41?=
 =?utf-8?B?NFl4Ris5blNFb1k5dGpsNEZQT0FEOVpZaXowbEhrNDU3TjA1d2IwRnB5T3Yw?=
 =?utf-8?B?WjZhM0k4MlpiT0ZLMjlCTTgyWnVaTDI2V2o4bmt1NmpLbzdlSjhxRUY3VndG?=
 =?utf-8?B?S1dKTk9FNGFleVNSelh3eFgzZmxDUXgrYzJnRzAzbnpGYm1ySFZmNFEzNWVq?=
 =?utf-8?B?aTd5TVQ4Qi9RSzZEc0hiS3Y3dU96VjFyeHl0R3MvOU9VUzF3c1AvYnNYQTJW?=
 =?utf-8?B?aFNKZy90LzQvdXh0aU84ajFTWlowbUhpUDZITEpCV1oydXliTEREUHRYdXUy?=
 =?utf-8?B?Tnd3OUsvNlBqQmxMZGIyL1dLbTZ0aVR2YTBKNVBHZG83QVpjS3FFVWtTUS92?=
 =?utf-8?B?K29MOFZYcTdBNTBYZUdaSzNUSTkvNVJsSllOa1Y3bE1lVDdPRnlFb3ZjVGVa?=
 =?utf-8?B?YnJtcnpaWTlBQUNKTXBRMHNKUktrMkZNbXdvK3dWa3JlRFVBL3lkTDVkVWtp?=
 =?utf-8?B?dXZLM1RZMVJ3dXhlVnJGdUhTQi9VaWszcVdDOGRqbEpsYThxcmkvTDBTYjQ4?=
 =?utf-8?B?ZXZLRnMzRnUxbW9pdGdXUlh4MHpnQ2FaMVo4UUY5SHBGRlRDR3dkRUdPSlN1?=
 =?utf-8?B?RDRoVFk5eEJzK2xIUTRMMEp0RnNUbVVkRWdjalN3NHZlbHFzUExjc3BZYy9L?=
 =?utf-8?B?UnNYY1dnSk1SQm1NUHNMZ2M3NmU0cG0xYlU2QTZyYnMxUEtVcjNOZVY4ZWJW?=
 =?utf-8?Q?wHQMxSJF54grUWvW8xK62eKPu8Q+oW+E=3D?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dee115-ae5b-4d8c-a04a-08dbd6ef8f60
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:20:59.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhIaFnm4jtb0EIpoq2/cQwJknfjMBHtz4AZKLt60n9je7UHd5EWxRSiC98taWluajhTHJXlWqt5bpVMD+yQcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6792
X-BESS-ID: 1698412881-104951-12366-1418-1
X-BESS-VER: 2019.1_20231024.1900
X-BESS-Apparent-Source-IP: 104.47.57.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGpqZAVgZQMNnEyMAs2djAKN
        k0zdjEyNgozSzN3MzM2DQpLc3AxNhCqTYWAJJLkRtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251720 [from 
        cloudscan8-211.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/23 14:46, Greg Kroah-Hartman wrote:
> On Fri, Oct 27, 2023 at 02:36:55PM +0200, Miklos Szeredi wrote:
>> On Fri, Oct 27, 2023 at 12:40 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Wed, Oct 25, 2023 at 03:17:09PM +0200, Miklos Szeredi wrote:
>>
>>>> I don't think the Android use case counts as a regression.
>>>
>>> Why not?  In the changelog for this commit, it says:
>>>
>>>      There is a risk with this change, though - it might break existing user
>>>      space libraries, which are already using flags2 without setting
>>>      FUSE_INIT_EXT.
>>>
>>> And that's exactly what Android was doing.  Not all the world uses libfuse,
>>> unfortunatly.
>>
>> No, this is not about libfuse or not libfuse.   It's about upstream or
>> downstream.  If upstream maintainers would need to care about
>> downstream regressions, then it would be hell.
> 
> I agree, that's not what I'm saying here.
> 
>> How should Android handle this?  Here's how: they have an internal
>> patch, which conflicts with the patch they want to revert.  Well, let
>> them revert that patch in their kernel.  It's not like it's a big
>> maintenance burden, since it's just a few lines.  This is the sort of
>> thing that downstream maintainers do all the time.
>>
>> It's a no-brainer, what are we talking about then?
> 
> I'm talking about a patch where you are changing the existing
> user/kernel api by filtering out values that you previously accepted.
> And it was done in a patch saying "this might break userspace", and
> guess what, it did!
> 
> So why not revert it as obviously you all anticipated that this might
> happen?
> 
> The "internal" patch from Android was just using the upper values of the
> fuse api because they didn't want to conflict with the upstream values
> before their code was accepted (and it was submitted already, but not
> accepted.)
> 
> So how do you want developers to work on changes before they are
> accepted with this user/kernel numbering scheme that you have?  You just
> broke anyone who was using a not-accepted-in-the-tree value, right?

It is not related to accepted-in-tree, but server (userspace) side now 
has to set the flag "FUSE_INIT_EXT" itself, to tell the kernel it knows 
about these flags and that these bits are initialized. Not setting these 
flags would cause random issues with any fuse userspace/server side that 
does not have zeroed 'struct fuse_init_out' - from my point of view that 
is a regression as well. And In that sense the patch is a regression fix 
- which now has other side effects.

Regarding out-of-tree development, I'm just right now in the position to 
have to back port my own features (and while they are still in 
development and being pushed upstream) to older distribution kernels. 
This is one of the reasons why I currently look at each and every fuse 
patch that is posted to the list - I'm looking if it can cause issues 
for my company/myself and at the same time I can give a bit reviews and 
maybe help Miklos that way. (@Amir overlay patches are on my todo list). 
To be honest, given the rather huge Android overlay patch, I'm missing 
reviews from the Android team... Especially for Amir, who took over 
overlay work. And if Android team would have monitored and reviewed, 
they would have noticed possible issue beforehand.

Thanks,
Bernd


