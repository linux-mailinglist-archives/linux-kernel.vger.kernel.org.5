Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880AB7D6638
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjJYJHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJYJHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:07:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BD9B9;
        Wed, 25 Oct 2023 02:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGY/ZgwDPFfKNNZCpOOkBFM5nh2tWi7XcPNwyO+2cuSf5DEIW4nPdBH42g3pyWqa7213RmV2cWYq83ummehLm7YKs1gIkpI2shgdjjcymv4nCs/Kqih3SXV4sFhYBLf5KHNUrdfUTBCZwGICg4CMDLTkt/knXC96nJopBrOBuNSOF1b0n+Hopc1hc0gwVzp17caOI9JLlAgUYGrdnU4hBl7G5fr8ngg0loUiDXiVEn1XS3tEFlP1IWXGTZqd8Z0frbHuEz2//u3/5/NYPYVTQTspd+HIJn0gKb4xbpXOtIXRHHnYl0z89kK0/mMU0edI3Cpchpg4Ts0VdBAso/Zz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyXiFWVTnfVhLjDaNHo0JEBjfmy4UrkX/JGVvZsl3To=;
 b=Hgb6Ne6kwffotHU7ao8lvRiQkIcQtTlrzvhTwB4OW+TAX8IEYG4JQBYXEY9zIW3Y3tzkE81ixlIRwT1peU1dvQsGJhqiPslXknROIGOzaEIILSANH0Keb53BHyI0qr76iVCPVuEGLXYdsd/+uINbam7TJKeZpvw0ACQ8s8J/GnRn4HAiJxiS4vvZOT1vQjADiRtJuq76ZqeumH4EuFAIASqaE91J060wcQaTyP3pyO9WPYWQ02KVdC4IXCiLLPAPYtdDiIEB29mJDnGZIs2G8e3ay1Ym+sklhlxAiqMWr8L7vt3ft7GXrY7Dx5djUJrso2Qgwvo2ZyxeaS1A1hUvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyXiFWVTnfVhLjDaNHo0JEBjfmy4UrkX/JGVvZsl3To=;
 b=CIt5tbzQuB2qIuB9lL3r1uX6gcWgn/wXbaiYQ0XrsIhQC8TjPJSC0hm0QOR18AER/Azao8wYQm1CCvRuTslfm99iMi734T7GS3V7sEh43Dxr1m09TBJaUQTbPx57lq4mLcqWTe30kE7t9Y99Ib9Ke5itcnzb7ch3KsJr2OYE2FX0YUYGCxufv7AdbG90JYsVFW/TxXWAP7E7B3E8W00wtEmc/wOIAXmylqZBKRVlCjJJnDAWEDVRz2L0PmRWUKUMelMBnuZnYa3HHXJYW3zk/dmx4NziJElvKJ4/jPuH9ULY1Znri0fd3I/f8/g4TvWQWVgycSIKdNzk5Wxt4Uyr1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by AS4PR04MB9483.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Wed, 25 Oct
 2023 09:07:10 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::3657:7461:c274:d71]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::3657:7461:c274:d71%4]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 09:07:10 +0000
Message-ID: <bdac114d-2366-407a-bfe1-fca2bb035429@suse.com>
Date:   Wed, 25 Oct 2023 11:07:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: storage: add shutdown function for usb storage
 driver
To:     Alan Stern <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Li, Meng" <Meng.Li@windriver.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231023054111.2744872-1-Meng.Li@windriver.com>
 <33bd0779-bfe7-4c87-8fe6-ea8455df3b6b@rowland.harvard.edu>
 <PH0PR11MB51918DD50651DB6BE937BEA3F1DFA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <3fe5b43c-a5aa-4c6a-8614-03a4d9dd53e2@rowland.harvard.edu>
 <2023102428-zit-quickness-9b73@gregkh>
 <5107f6ca-e972-4af1-a21d-6c95778969f3@rowland.harvard.edu>
 <2023102459-protector-frequency-1033@gregkh>
 <a6bb88cd-0b89-4eb1-b90d-8ad633b7a8f2@rowland.harvard.edu>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <a6bb88cd-0b89-4eb1-b90d-8ad633b7a8f2@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|AS4PR04MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c10aa94-8e29-41f5-102b-08dbd539c4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9RS0YUYhgbWHHmkaJ5C1M5SE+kraaQqG5/kpsDEAByllvKHNEVaynDHnglGw4kvj7ksLJZSrFf5XUe1yH2V7p3hPu75SMFHe3CgFetoPfKrULLlYrKh/Osrgc0HsDB56xyUzKGlXGTPce/QnI6Ae2rzEXxfF/xzUwgxxvgDqtmBaXnDoWmyhpdDkNAd7F0XGcSTVqL5IN5KO8OhaaYXLB7ircOYPxGM07x+ZmST/PEVfWN3wm0voM+PTOfxtaBSo+Y8D5PScpT8S/6Wcur8ZfMqn6wdwcbTWHEB+3iYk+Hjs1z1OyH3po6Q/30CwE6IBTXD8HNCPcXWChPOWg4k2awr6z7KTjqD6swaKKUiXFvUo4HlwFaVEdgDK+sysfIQ7ae19KcYOilXsu0SAwZ1N/TJpmKZ6yt18jYBxmZDcKWds97FDz5IK4dm9zCmyvjPWRCHzlmiu9XTJK7eyCCM8gGXSoswmLVKfJdRvAjll9bZgjMQRq/KC+WgYp/K+LyzfMAJJTiHW5Kv7Kx2kZLwlel9FRktCHj3oynA+1MHJxzSsapY7+Hw3FbA09G7XIzpztiHJx/HNZbe/pe++yUPQLOviPveEqBWVUBbFKJvr3c11nHF47+RHf099UOwmpeDVgX9z2/73Owai4aDPpc8tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2616005)(38100700002)(316002)(110136005)(66476007)(66556008)(66946007)(4744005)(54906003)(2906002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6666004)(6506007)(53546011)(6512007)(6486002)(478600001)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJsOFFYSmdic1hjaGhnemdZNzVuNmFrMGVjbW9tTEo5TTZKQnFSSVFsUnN2?=
 =?utf-8?B?UCtPeVpRY2dYV0NNR1RlNDZtZ3NYOEJzQlFhSGh4Y2g1bGFUQnIrU3M0dUlK?=
 =?utf-8?B?RFd2NVZiMDZyWE1IVzJJUTE4ZHNNMWV4U2d2aUorellDaXFrOGVpeitobkdH?=
 =?utf-8?B?SW9ET3FiVCtCcUZBaHlXVENGMG5xMFJib0NLSDZWUHc1SEswdmZla0ZiRFhH?=
 =?utf-8?B?UkhRYWdubjhYbFFVb0JGWVZIRFFsZ00raW5oNkhJd0FKaFBSb0tIMnhCOWFy?=
 =?utf-8?B?b1VJYjIrYjRlZzFkZDJENys4am03cVIwUFMzZlVFSFU3Tkx4VEFjK0h4OHdT?=
 =?utf-8?B?c0l4OGhCNkVHMTVKTXZKeFNMOGczMGpkbndlNjNZcVk4cmpwZHVWZTZuemVW?=
 =?utf-8?B?ZWc4S2pxSkNncitQVkZtWnFYWXdBL3FUUk9vMlp3ZmE1a24xa3Ira0RCRloz?=
 =?utf-8?B?SGd3Uy9PYi9lU25ianhJaHJYRUNZOE9vK0JjOUVDbk5yTWZ2L0UzcjM4Rlds?=
 =?utf-8?B?UTdIaVJBU1FMMGFUNTR3bzBmdjBqc3hLaytaSzNKM09VZ3ZydzBZN2xXQXlQ?=
 =?utf-8?B?SS9vM3lpdjlLeVVWaU01andZNzVHN1EwcmFxY0xKMm9wem9CYTR4OGczQjJL?=
 =?utf-8?B?TGVmMkUyQWNuWWtuelRrSmhSUE8yeHFWd0FRUTliWHoxRGtRYjJLQWExemdk?=
 =?utf-8?B?ajd0ekQ0Ukt3cTl4TlBOUGlFc0RNak5MRFBhQkwzRzRvVGo0ZHNLZFU4SW8r?=
 =?utf-8?B?a3lKbnpyUm10K1FiUFZlUGx3SERaOHFDQms0VitvMU5QUW1ySWxnYWNoNjRY?=
 =?utf-8?B?ZTA4djdXWmZnK0h1MkRVcUZhaXJiYXBpdGdROW4xc0xkRnk1MDk5RWdZVXZI?=
 =?utf-8?B?Q1FwTWExdnpxS3FUTE5SZWNuT1J1eExST0JnWTFDV1lNZTVKUFhHMlRHN2Vp?=
 =?utf-8?B?UWJjZTFsVjlGSER0TDhBWGloMkd0TWIrOTNqRG5kVGxwdkJwT3huaFZERnRO?=
 =?utf-8?B?bGkxN05JcnBhT1ppZDJoUTdxdktJNlVhMTh6Zk92R3RMUjBLMHY0NEhHLzNq?=
 =?utf-8?B?TmxuQXp0bWdodk1RMXlGaWdudDZhMUc2U3R0OWhteGx3bGoweU9OSXlFbEJu?=
 =?utf-8?B?aGhnbVE0ZFk0bklXejBSMk5PTGt2SmtsZjBqR1VtdXF6NThkTUFRWEFFZHZU?=
 =?utf-8?B?NEtkeVNZelBjRVhrd3VSNEhIWU05WGpSeFlscUtIcmFuaXlVeWw4VUhmUjNu?=
 =?utf-8?B?M1ZhZEtPY0lWWnNsMGp4TW1DemNLVVUySDY1L2owK016ODFScmZwdmE0M3k4?=
 =?utf-8?B?N1hqRmk5TnlKclVNWWdubm1LYlBNOVZEaUJtZDR5WjZLVloxUkgyRmMzNnRq?=
 =?utf-8?B?Zkx5UGlDbTdIa3pjanc4YUNlNktRRk1ncy9TcEpLTko4VkJzMzhWczVZcklQ?=
 =?utf-8?B?Y2hTYlFYSm82WmNqekVhTlFzRU1SMlZnSTdPYnoxNUpiUXc5VUNlZFZSVzUx?=
 =?utf-8?B?a1dMOCszSGNlSXNyU3h2Rm5JblZBdCszYzZpMjJQTzlYN3htZFNBSUtTTm5S?=
 =?utf-8?B?VWhTTjc1WVRHMUdleHNJUU1zSkFWMGZUYmJSUHlEVEswMjJoV2M4VzB0eVFz?=
 =?utf-8?B?V09XZHpyZ0M3ZXdjaUU4N0J5aGNsMERuVEJxT0IyU0VUZjN6Yi9nVlkrcUJa?=
 =?utf-8?B?ZE51K0JrcVhPZllzaHM1R0lWbEtQUmo3azZ1RWRxbHYya2hwN0kydnlCWUlI?=
 =?utf-8?B?RDNEYjJwaDl0YVlaQllNdjl1OUVUd0JUS1NvenZDVXR3MzUySitEUHlGNEE3?=
 =?utf-8?B?c282Z2ZGdXdla2VURGh0YVd1dndLQ3RndFpBRXlNTE5ic3NOQXZ6RVcrR1hk?=
 =?utf-8?B?aFdlTkFIVDJEMjFNZk9obWRXazZUODRBRXpQZGZVbjRLMzMvWjhHckRnSG9V?=
 =?utf-8?B?M2lCUVdoWkhIZE5FdnJNSXYxTktlbjlrNjRtdklJUDEzU1krV2J2TDBFRkJl?=
 =?utf-8?B?MXpiZmw1dFVzdTFsUmtacUJURGw1RENWeFYrL1k1ekNVZ0MrakVmcXdBU0RM?=
 =?utf-8?B?RnY1bC9tNU53cWlMOUpYTU9wU0U1c0FBNlNNQWlGY25DbHlCcW14cGVYMm9P?=
 =?utf-8?B?cXpYRG1ydlYvMnAwQkJWMTFCbjVJakNCVjZ5c2k2Q2tZdEdFYitiNnJSUzMz?=
 =?utf-8?Q?iruL5Em7OIMtP+WAdLiZjT2HB958cRBVoVSlfGDuwWMN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c10aa94-8e29-41f5-102b-08dbd539c4ef
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:07:10.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRVAvGCDquLPDfgJzz0LH4j/5Yo9LSrvG3C79hewAgCDYA1BDmxwm3qVMb4QUOxVGidyLGD+o9DnCDzLPM5Y/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.10.23 21:23, Alan Stern wrote:
  
> Since USB class-device drivers don't have ->shutdown callbacks (there is
> no shutdown() method in struct usb_driver), they don't know what's going
> on while a shutdown or reboot is in progress.  All they see is a bunch
> of errors.

Does this solve the issue? You'd have to flush the cache on the SCSI
device further down in the tree, if you want this done properly.

	Regards
		Oliver

