Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7A787C17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjHXXrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjHXXq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:46:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B919B0;
        Thu, 24 Aug 2023 16:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+21dh+UDBiQTUfZtcHwzVd71ZZhXrDOL2V7zMqMox3OhODL7D1KhHTB96gjLD6mYYsFZwzW9PL9c6LAtjOQFjT6l5/EP5wFMf+tSqhaNQ1W3WK0lI04ESSTiTKuJr2+fl1TX192HeB1qCywBhp+ElxssCEzfAbtgcX/fR2Z9vQ8tpBycHV+86seJ7ubmxRAzGfAg6vxvHNxX5YH4HWpnaqQ+jGaN1Tg7UIquSQLqdo0xUsWDcOxyi3SFhmTX0LSImfBW8wFpdznPl2Z3cQLTT8QvaupJJQhPoB0dv8U5EOUUJrOYfRS3rA1yNLe0o6b21EPDyNIBAYX7RpTPTZV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJU4Xu97GnZmG2a/4OP4XyS9pt+OTZtEmBcd+XAQmJc=;
 b=ElSRCXGbf4+F7jXfvPRJx0AabpPfZR/UC5AQkxMR9ZdKaG7CIP8LTQF0VdiqQHAlIXNT0A9SdFexC1xyVPYMi7WWYsp4W0U6Yuma6DuXq41vxPTDzFydNQAeblNRpPcruw0fpMrNODCX3i3ofR3qGXZhegeCGB8YfZ+UvI8vY8LgcHuYPrGuAlYtfQHc7RjREa6hyBD7TBLmVFqteJGMJnM1YVAOXXlPaJeLS4iM9bOUkh9W1k9LbE347vh25cnLRwDh66OhbCPNytxMrUStQ+KjX36BsAeYK5AJWSRaDtGqQX+noH6z8USlO2OV6J95gx5xremLXw0IWdAUl4Qr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJU4Xu97GnZmG2a/4OP4XyS9pt+OTZtEmBcd+XAQmJc=;
 b=AMeI1P2L9oZ6DBLK/Cij/AStUXdbmEGBfxRafDok1Lk34grEQ9rg1V0AbJnc0JMmaw6r4hPd7T94FhhU5yrSDX1m5cK0bH3Ww7Vxvl43SVCsQuhou4rn6V4GhJ/I5A6ZkTayF947E+S26uAVZlIqDRhbpgY1U8y4GiEIjo35McrhZurDluoNJceQ8G2cCuGV7aUQcCRyGKWtBf8oxxmWqC0Z2Ru250glgOkTiUKJ7N73bIaTloP5BBEws9Keckc3eHD2ZKU/aJ1RddZrD584W2irOyjoaSaSyUXJy3UlDY68fGBEAShhp19hdqTSYZK6QIH/hCnkJS90vOLZmdUY0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by GV1PR04MB9119.eurprd04.prod.outlook.com (2603:10a6:150:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 23:46:20 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::51fc:914:29f5:a420]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::51fc:914:29f5:a420%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 23:46:20 +0000
Message-ID: <f1b001d8-4d6c-8c9d-a90c-7d97294b66b4@suse.com>
Date:   Fri, 25 Aug 2023 01:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] USB: cdc-acm: expose serial close_delay and closing_wait
 in sysfs
To:     Simon Arlott <simon@octiron.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <2023082403-masculine-scuttle-f0ad@gregkh>
 <d313a1a9-833e-981e-b9d7-920989458d37@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <d313a1a9-833e-981e-b9d7-920989458d37@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|GV1PR04MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cab362-fb79-4ffe-83d7-08dba4fc50e3
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV63z+lZ+dPnwL3Jj0av5vYLVrod7r3w6GhlU7OwmV6doHCgNTmBomdtffBo50nL5eFHjrhypyp6MmOwuzVKpvRde+lXPQWKRXdqyMfYFzGW+X/jbdVIEb5tcVRUrB1CHEURZcCfYtC6sImkApZ5b2eHorJ5EdZhT82XmtIxwz68w5SUdy3gUHQ3nVJSpyTs9raKMPeQPZmb7wsoDdpjaBpyUWgp0t8EXEv8gp+gnTJ5V0mYmV/JIgGcd5LOHX+s0fA2lLbolCdE9IdBWnbjn4n38pQmpKyMvjnCkO+I1jA5oOgbP/tzgY8Fa7FcUbw8Hj3GI/TEXBhR5RU+rLtpBmg+/Cbbzbe5O1wuUQZlMNKhKt3xaOXnk69kCsxxTqzfhiKdzXers+FsyBtGSwOFMW6JdgWT95BeX5qaRYW2pnTvRaQA2JmnZfMBYr+59u2qYVYOUls8eYqkKNfeZRO3qaW6jjLuP81kI36DycZ/pOgVT3LYuhOKFxxqsDuST7FdTu+BWAlMh8LkEq8xiz+pGWPmwL2UVZqielITqFu/Qt1MbyKeTdz4wWCf/C1dqqf+ArmDfzorLAG4L7oHkoqNjdFF0F7YMlXDvjdnZ3R/ipzOq3y/0TitGG7nP8/qVM8s4nEPwW5nuC2BsCIZl1VfPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(6666004)(38100700002)(66556008)(66946007)(66476007)(54906003)(316002)(110136005)(478600001)(31686004)(53546011)(41300700001)(6512007)(6506007)(2906002)(86362001)(6486002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3luRDlMSlRFUitHdFBjRzBnMjdnUFpYWW44T0w0YVEvZFo2UmY2YTFmaDVL?=
 =?utf-8?B?MHE3K2FZN0UrSnZsTXdGYTJqU2hrckh4VmhYKzNNb1ErMGpQSUMvTEJPUHdT?=
 =?utf-8?B?S1VtZlFqSE1DUzVabFpwVURrdi9rUVJwY042TG5WbDRabVVRQ3U1T1Z3UlZo?=
 =?utf-8?B?dTZrMUNVSHQrcG10QXgwTjE4WlN1blQ3RXhBcEN1ajc3SXFkMURaOXNVL0FI?=
 =?utf-8?B?RU43RUZDcmJoUms3b3diZkpYMUswbktWQzhWMStZVHJVOVZSTHdqeXUwMXhp?=
 =?utf-8?B?NXh1QnJPNGxlRjd0cWkvWGlrai9hM1FGNjRVcVcrcDF5WjdyaHVYMGR5cVhN?=
 =?utf-8?B?TmgreEtDRDJKN1B1OFNVS2xaSmg1WHpQNUY1aEs3ekpoTEw3aVFOTW54Wmo1?=
 =?utf-8?B?Ym1uUjFvdEdDUGpYYkxCQkZVRVVEeER0ZjhQRlQwQW1FbExRdkh4NlBEYmQ1?=
 =?utf-8?B?eE5mRDBvSi9TZC9kSmwrdGhyQUFDbFQ5Rm9pMkNKRUpUMmVpRXlLa1c4Mm1E?=
 =?utf-8?B?SXl0VnZPTm5qN2Nzbkg4U2pTZXIrNkFVWUtaRlhkeGhoYURlNGlNTHZwM0ow?=
 =?utf-8?B?SWEzYmN1YXJ1cTVwdEQ5L2gxYk9ocWFVak5uaUlBcUNjUVplKzZLekNUU2hq?=
 =?utf-8?B?VG9WbGtIbER1WWR4eFFVWTdwOWs3eHpNYTh2NWdPZkY2TFFDQmNPUG5veGxo?=
 =?utf-8?B?dndJRWlzM0thZDBmOXRySFRSNkpIVmtYZE55c1pMbWRoeDA1a0hQbkZqNHJ2?=
 =?utf-8?B?YmhFSGFqYlMyYmJQbEY1ekVHYndQZW1ieWtqVVJ4a2U0TFJ2am16T2p0MGRm?=
 =?utf-8?B?ZHZ2cFRzZnBTaGlzaW84L08xWXpTZ2FHNXhTWkV5VjAwWGtGRmh3WEtWMnkr?=
 =?utf-8?B?TDBGbEw5bG4wUjlZMk1UYUROdnlqdTZTZStZU2h2S2J1TmV4TnE2VTV1Z1Q1?=
 =?utf-8?B?TWtia01HUGpaSXRjMUhJNFQ4eEFmV0lmUlArZDdSRnZ4b3BSOGd3WmhpU0Mx?=
 =?utf-8?B?cUxGYVN0UjRrQ2JpU2NVUG1lMmErWEo3VGx5S0x0d1hyZ2hya1BJcXhXZ3Ni?=
 =?utf-8?B?Z1YyV3cvRjMyTWlPck9uRUFndGpUbGVPeWZEdHF3ejBFT1B2ZkY4RUJqT002?=
 =?utf-8?B?YlJYMlFXbjVCSytPZmh5dEw4Unova1VYaWJHTEZKb1JFUnNYaEVPVzNGbFha?=
 =?utf-8?B?ZWRCRG10UXcyZGJEUWUxUFNWUXBQRlp5aEQ2L0R0bXNZVFBiTDB1QlB6eXBV?=
 =?utf-8?B?dzdmeFIzdmQyVi9DNW0vc2N4Y2pPOTVzTWY5WndjZGs0U2d2bklKRnVVRXIv?=
 =?utf-8?B?cExnR2IxZHpVYlQxc0p1bTF5NWZlejJpQTh5Slk5RkZSWmxpREpRR2pBSEdQ?=
 =?utf-8?B?K0k3RTdWejhhNlNHNFFkVkx3Zk8rNHQybVAzeXFYa3J3OFhaSXY2UkcvK2Rm?=
 =?utf-8?B?Nzh6VmlGT2RJL1RmT3hsSHl0N09OWWRXUFh6QU9TaUY0TXlMc2taMCtpNlJU?=
 =?utf-8?B?V0R1OFVNU0FPOW9PT0Y4WVdScjZNSDhBdHZ6T0ZuTHJYWTF6alBWV2ZtWXZz?=
 =?utf-8?B?cmFOOE9PU2FOelBDbURsWTZUSVNpREZ3bzRPdjNSTFAvTENuLzhLY2E4aWJZ?=
 =?utf-8?B?aGZQbFhpaVR0dVVUb3o3SThWNlZtaER4WDhvbk9idURXSDZaRlY4ZThXZUcr?=
 =?utf-8?B?c0ZZOHRmL1ZodnFoNGNPeEp0S1VtS0prcGswWDRQZE54em9tK2dTNm9QcHpG?=
 =?utf-8?B?dE5ZZytDU3JKd05MaFp5RENzbFF4VE5uUW9oUytjV2xnVXF6WWQ2MHZONEZY?=
 =?utf-8?B?R1Jva1dIRGpHbVN1amxKVEdkVXFTZ2kvdGt6UkR4Y1ArUnZNbnN2dmozUVVy?=
 =?utf-8?B?L3JWSEpTdXgrSTJLMkY3M3o5N1NRTXJlNndNTkoxOVRkQWxnS0tmSkN2ZmhY?=
 =?utf-8?B?MTE1cmJOR0ZlZTZSYzRJSzJsQnFLdWEyMzJjaHRSazVidGo4T2VUTjc2LzlE?=
 =?utf-8?B?dmc1Kzk2TU9lMHF1c0xiS1NyRStPWDRIYm1ZVkU3blZndC9xVmJBVWJMaEpD?=
 =?utf-8?B?Z2x1aDVURVZaSnRoRkxBQ1hsNi9iSnZreThYRmxqQWZ1MU1BN21sVm90RnRX?=
 =?utf-8?B?TTZzNGtNb0orMVR1My85VjdSUE96N0FSUTVHaTQvWTdkYXBhcW1wK1cwSlBN?=
 =?utf-8?Q?kthIJvsmXobAZ5n32CuTXQuN/1iw1e65Cxrp+35dwZfp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cab362-fb79-4ffe-83d7-08dba4fc50e3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 23:46:20.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqVajF4QjA9Vtao4ik6W2hiiX4AQ4WnxMn1+b54HnBehdeccJWwSgny4HdBewNF+IVeikICqTLVgVlr8sjOrtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9119
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.08.23 20:02, Simon Arlott wrote:
  
> It's not practical to use TIOCGSERIAL from a udev rule. Instead of a
> sysfs attribute (that udev has built-in support for writing) it would
> require a separate compiled process or other non-trivial dependencies
> (e.g. Python) to modify the closing_wait value. There's no shell script
> support for read-modify-write of a complex ioctl struct.

That, however, is a deficiency of udev.

> The ioctl can't be used without opening and closing the tty, which has
> side effects. On open() it'll raise DTR/RTS and activate it. For cdc-acm
> that will indicate to the device that the serial port has been opened
> which will be visible to the software running on the USB device. On
> close() it'll be delayed by the close_delay if any process is currently
> doing a blocking open() and there's no carrier, then the closing_wait
> time if there's been any incomplete transmitted data (by any process).

And that is an issue of the generic serial layer.
  
> Those two values require CAP_SYS_ADMIN to modify (which is separately
> enforced by many of the tty drivers) so user applications can't change
> them even if they're aware of them.

That is even more damning. Either something is protected by a capability
or it is not. Such a protection must not be circumvented.

	Regards
		Oliver


  
