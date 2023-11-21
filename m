Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3CE7F2644
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjKUHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKUHXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:23:52 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98819C8;
        Mon, 20 Nov 2023 23:23:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXZIPv10FYu2bgM/pnGePsfFa+D/sEtXNgbEuJvfthMbeuznX5q2jyWhGgksgX7UIdLMlHvL5b07pcMxlLEbGZf3n09zNcRw+vd2IlefUDB9UCcn8KsJLmpnIKQjw+FpBb0p6NwoR6Lo0BLBPwJsV1gLjvVhTxglrPNK7Q70gW4cSG6/QRD5BSr1N3CPU/vKRezoVaTuuGFD96vuMp8WZrTn0vJ4fYh/PW0UvktrjMrX9k9cuJzwTKjp5PBniJcPceTAQqrbL1pWwP9wrhoPkttJdhuJGoLhwHEUGHaKuGAUEJpMYWcQTbz9lmKF6wLHjETGRujWpvMj0AU3i/YdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egivOOTA+kMeF3cKWb3OstZ6/brHcJ7v0z5B9oVlPPU=;
 b=ekhQJYHusY76YrpOiqQxSKo7VkqeVgt7ZdHGS4lG8T8oZCsdwj0wOJNk+fJ1qm7I1t/VEVVcZct9BrqwlbSjPpe3OFSJMpB1ZM4xFOBjMhYxWjSf984dj88k0uidOAJfqv7M4fySa6E+6sThf1EOzoVyTwB90Mz+MCR7y/w0eoVIKkAmkPdfsSSOKdYOkMYg8ay6QL/p3PjW1W5adcHFzlDRr6C4mNT2njftKdQIAW7xVk0+KePRHAoZejDPrDT87/5MpUsRxHp/CkLKQQqueHe28Qu95e0BJlclMnCbQlt4lbjZLXmLSGCgsnvjodH66HbPCWevkxXUzYX+Hx+XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egivOOTA+kMeF3cKWb3OstZ6/brHcJ7v0z5B9oVlPPU=;
 b=jMjfaD3NhDQp7SA5reSUNB0F6KNclILPK/HgSYg1pAV7c51+vlmKTH4a6jz+VnORJ4I0FYw1M1e68vGXQAD+Hc2/HyOXp919bVA4riJjHLDhqIDExihQW+c+1AfcYAaycJVkM/GbIYb35shg/QG9j3nCsWT7Jp7j/FIIycocMl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAVPR08MB9259.eurprd08.prod.outlook.com (2603:10a6:102:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 07:23:43 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 07:23:43 +0000
Message-ID: <a56d5b63-bc21-47b4-bb58-cd7b82163e24@wolfvision.net>
Date:   Tue, 21 Nov 2023 08:23:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v5-2-ff6b5c4db693@wolfvision.net>
 <ZTp72LUXxr+Z9gn8@nixie71>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZTp72LUXxr+Z9gn8@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0039.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::28) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAVPR08MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5e8e66-004f-464b-efbf-08dbea62ca90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSd6EEYHSwkO5pcrF55BJFe6+UjUXjaUecngCbm5TnG34l7bwfKxvpgZPcWAd+25Zrlj3Uwe42r6p7WOl3O20+Yvk8ZZMeA3EWlrAa50zTp0laIbxnAVGxKMM6FOLzVcWGTACKLv7S9gwEKsaJ9GSzNQ62G9rUvlIJR5MJdz4GQ/SR61/cEYYg3NF/sJSeqR5ZgNxEGdqelnmtwqMwI1i1o2iFwULa3b7jkorjNq6lMY0H4D4RROWGZzX2oxh5mqGWBqDgJ+J2mUQKnJ/AddKffpUav2UuYH+s6py/vy9xh2qf01X1D5ijy9tqzv9rYBwBGZHefFQyHw9fndFdklZFMmKQywkV8fpIBxEi07A7bCVZ9r3oW6d6nfxEBBYg0IpkpMSk4TwXkJfe7+0yv7+0aVmU5dFJzP1JNk98KDT3e5rF2cjmEySsfw20KWHTSOMayr97F6W5LsHKr34BgxCcnXHjdjppw150lrONaqfzHURMRHWU24PlFblkC71pMeu0TpQcaDirYkw18OXrzdFFN566INvv00ymj0wHZMK06yKuw7Ue/J2g7HLB0TI0IhGJIwxKRQVHy0L4zNgpHUvwRzvDESf6vK2HIE59cFNHLjmeZeWJVs6ZZvio++2R8h2Iacy0qoXP0qTg/cnlSCUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39850400004)(84040400005)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(5660300002)(2906002)(26005)(8676002)(2616005)(8936002)(4326008)(31696002)(86362001)(66899024)(44832011)(41300700001)(83380400001)(36756003)(66946007)(54906003)(53546011)(66556008)(66476007)(6506007)(6916009)(316002)(478600001)(6486002)(6512007)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVxb20xczA3TFYvaTkwZkdFRkhVUkRwdlcwNFBzR1g4cUtNMDZDSUFTOWZ0?=
 =?utf-8?B?VmlaQkpIM0hCVk8wQTNwaGIyb1NGVHVveFlZcHV2UVNPMXpHeDNhb0VtQkow?=
 =?utf-8?B?QWsrcVdrTGVWa2tLMjFYOTYybVlXVGJEbDdremx2QUQyV0EvTWI4YnptdUNz?=
 =?utf-8?B?Nnc0WjVaUThSUGVjeWdqUm12aVpVUjRSOVYyVHMwSng4VDVKbUhXOHJRYlpK?=
 =?utf-8?B?VE5oUkFxVk5mRHdHdFIyamhVcWVITGtuc3d0OVZkQmhyTTJyRlMzZXFPVyto?=
 =?utf-8?B?bUR2clRQbXRYNGd4WkNMM2ZkWnVlUlViY1VLZ3RDdGZzUWp2SEd6VHNCdVRv?=
 =?utf-8?B?cnJpbnlSdEtoZEJGcC9FMmExaDM1L2gyZWRIdldCUlpmVUd0TGgyQ09sVDI0?=
 =?utf-8?B?UmtUU3U3TnV4YXRMUkhvVWZpRHZiSDdoL3VBd1dlNGkyU0M4cW9GOEdLS3BD?=
 =?utf-8?B?VEtYemZuZ2kyNUVYcVZid09scFYzdWsyU0pLOU5FYmdOMmNmNHR5cVBDdkIr?=
 =?utf-8?B?Wm5LS290UXBZZ2txQlh4azBINFQ0MnhBaGN6YlhqMmtnVEdCR0tacjY0bnEw?=
 =?utf-8?B?QjZxT1NqUXNYVlRQSlV2RmFWdzBteGlubUxKbDE1cnd6dkRRWHBZZjVCQTlB?=
 =?utf-8?B?L3dMZVcxU25UVGRXS0tOTzM5UThUMTkxaUVCWDBBenk4cGxyZVRmR3BNMnIv?=
 =?utf-8?B?VTR0bGZqdDBpaHZOTkVsYWhTZ01yRjhoZUN0c1h6Y3Vnb00wMzRyYmwrOVBX?=
 =?utf-8?B?Y0tXRnFtYWYrbEdLQ0xLSVZoR1JqMnY2YlVsSVRHM1dVZlh4eHJINXZjbUdZ?=
 =?utf-8?B?WmthWXV1OGFMVzhmaFlxbmlqV3lnLzVtNWN6b3gwOXJUY2hxV3d2VU04V1NM?=
 =?utf-8?B?MlVUUlVOMk9neDM5dmQ4MXJldEE5b1pybnI0QTQreUhwdG94N3AzUnlGWUNn?=
 =?utf-8?B?QlNPUFhUeWFsSW1xYW9zS3Q2cnllVVRzaGlFVmw4eTFpS2s5bEFLQUlNcEhG?=
 =?utf-8?B?RklZcFJsc0QxMVdJSCtvN29Qb2ZjQXZaZTJwKzNLdUFKQU83dnUwUDRZUzhG?=
 =?utf-8?B?dExaSFJXa2xyNHp3T2dreTM3WGp4b1JacnV3NGp3UGpac25FUDE1L1RrU2lt?=
 =?utf-8?B?QU5jT3NyMWU4RnBTQWdlVkhmelhJMStFbWVaWkpkSFl2YjJ5cEU3VG13ekdm?=
 =?utf-8?B?aWZMUWx4UElaYU9vS1F1NmFOMHdlZ2V2eUV4TlBwT2czc0dYZ0R0eXRiamJM?=
 =?utf-8?B?TU5HTndGeGRGM0kzVUcvZCtubHIzdmRlOUhFa0YxUWluOEF5eHlxNmRFYVVT?=
 =?utf-8?B?bHpyV0JMUWd0dEJpV0JiM1d5aGorRytuODBTcjFYanFFTUJWMjFyVDRxN1p0?=
 =?utf-8?B?VWhDYzRDS2ROQVRzSTY2T0hmZnZEbC96TnNldlM0cjA5L2N1ZllFLzVYVjNG?=
 =?utf-8?B?VFN3YnRYbDl3VDVsWmlJZ3FCWlROcXd5VFpJWVlOOXQwWWhRY3pqOTdpNzJY?=
 =?utf-8?B?WksrRG9RZVZEbmUwMkxZYm0zRHd6TFo4citmS0ZZYzREV0g0RTNTTWI0VUcv?=
 =?utf-8?B?L1BHQlhZOGVoVGZtZjJaZEJrbDZPSjFvOGtJTTFYNjV4ZGtxWk1WQ1YrREFH?=
 =?utf-8?B?cEhYUUY2d3dJZWxmeE4rOURCY3hqb1JuM1lZZDhJNHA1SmRGWFduMWNwV25l?=
 =?utf-8?B?RjJjVmc2bHNnQ3ZyaFNKUUY3QTRDOGVuUG9FNVIyZ0tOaUQ5UEYvbHlpdkk2?=
 =?utf-8?B?M1V5MVB0NWtUTzVrOEoxdGRBRTRoWWIvTE9MbHpMbm44eHVsdm44Nkd6c0J0?=
 =?utf-8?B?amNMU0NCcDlXVGdHSUN3TDc5QytCMjFDME1EYlFkaTJEejdPSHdqOG9CNEUx?=
 =?utf-8?B?K01mNlhOSGRjeWY1d1VUUEJqaWozTHRUQ21Bb2VkNXpoeG5aL0g3d3B2OE9U?=
 =?utf-8?B?QWtvWklseko4Z0t4YVVoQkN4TDZZMHBrdUdRQUM0VWZHOFIwempjR1YwOE1q?=
 =?utf-8?B?Q0FBeXorVGpHU0pCRWZ2cytlTm9ZY1JwS1VkYUJJV2Z3TDZwYldXeW9LaDFP?=
 =?utf-8?B?UytBd3RtNkxzWW4rYUVxRFozdWZYZmNuWTc5L2Vjb0NvalpYZUM4MmdTRGND?=
 =?utf-8?B?dmJyZWdsZnNGRXRMZ3NRckZHcmFGRkt0VGpEMzlNMTRRRHNpVWJEaXpNSDF6?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5e8e66-004f-464b-efbf-08dbea62ca90
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:23:43.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdciGrMTwT2LKP0rLwJ1JLoOH6sdlwi0h2sXjy0KPIh6LhDfr+fKqHpjgNN4ZwFK7OzszQjxOqJBcDW7dyZF2PqxrBdp3z1laW7o+ZMvWp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 26.10.23 16:46, Jeff LaBundy wrote:
> I am still confused why the buttons need to live under an 'overlay-buttons'
> parent node, which seems like an imaginary boundary. In my view, the touch
> surface comprises the following types of rectangular areas:
> 
> 1. A touchscreen, wherein granular coordinates and pressure are reported.
> 2. A momentary button, wherein pressure is quantized into a binary value
>    (press or release), and coordinates are ignored.
> 
> Any contact that falls outside of (1) and (2) is presumed to be part of a
> border or matting, and is hence ignored.
> 
> Areas (1) and (2) exist in the same "plane", so why can they not reside
> under the same parent node? The following seems much more representative
> of the actual hardware we intend to describe in the device tree:
> 
> 	touchscreen {
> 		compatible = "...";
> 		reg = <...>;
> 
> 		/* raw coordinates reported here */
> 		touch-area-1 {
> 			x-origin = <...>;
> 			y-origin = <...>;
> 			x-size = <...>;
> 			y-size = <...>;
> 		};
> 
> 		/* a button */
> 		touch-area-2a {
> 			x-origin = <...>;
> 			y-origin = <...>;
> 			x-size = <...>;
> 			y-size = <...>;
> 			linux,code = <KEY_POWER>;
> 		};
> 
> 		/* another button */
> 		touch-area-2b {
> 			x-origin = <...>;
> 			y-origin = <...>;
> 			x-size = <...>;
> 			y-size = <...>;
> 			linux,code = <KEY_INFO>;
> 		};
> 	};
> 
> With this method, the driver merely stores a list head. The parsing code
> then walks the client device node; for each touch* child encountered, it
> allocates memory for a structure of five members, and adds it to the list.
> 
> The event handling code then simply iterates through the list and checks
> if the coordinates reported by the hardware fall within each rectangle. If
> so, and the keycode in the list element is equal to KEY_RESERVED (zero),
> we assume the rectangle is of type (1); the coordinates are passed to
> touchscreen_report_pos() and the pressure is reported as well.
> 
> If the keycode is not equal to KEY_RESERVED (e.g. KEY_POWER), we assume
> the rectangle is of type (2); input_report_key() is called instead and
> the coordinates are ignored altogether.
> 
> Instead, the existing implementation has two separate structures, one of
> which inherits the other. Its corresponding properties are then parsed in
> a separate function to account for the fact that the two structures exist
> at different layers in the heirarchy.
> 
> My argument is that all nodes can be parsed in the same way, without having
> to understand whether they represent case (1) or (2). The existing method
> also has to count the nodes; this would not be necessary with a linked list.
> 
> Can you help me understand why the buttons must be "wrapped" in their own
> node? As I mention in v2, this isn't a deal breaker necessarily, but I'd
> like to understand the reasoning behind what I interpret as additional
> complexity, and a degree of separation from a natural description of the
> touch surface.
> 
> The only reason I can think to insert the 'overlay-buttons' parent is in
> case we want to specify a property within this node that applies to all
> buttons, but this does not exist in the current implementation, nor do I
> see a compelling reason to do so in the future.
> 
> Kind regards,
> Jeff LaBundy

I was about to send a gentle ping when I saw that you have reviewed the
last version almost a month ago. Somehow I overlooked your emails, sorry
for the late reply.

As I said in a previous discussion, there is no unavoidable reason why
the buttons should have their own node. I just wanted to make clear that
there are different objects with different properties and in case of
some new appear, there is no need to check several properties to build a
decision tree. Moreover, the device tree is self-documented and even if
you never saw this feature before, there is no need to explain anything:
every object type has its node and the boundary I would be drawing would
be logical, not physical.

On the other hand, with the current implementation a single keycode
property is enough to tell what object is being handled as there are
only two types of objects. If some new objects appear and the decision
tree ends up getting too complex, some other solution might be more
suitable. But until that happens (if ever), I can give up on the button
nodes and simplify the code with a list head.

I will work on that approach for v7. This will require some major
modifications in the code and the bindings, so it will take some time
until the next version is ready and gets proper testing.

Your comments on 1/4 do not require further discussion and will be
applied as well.

Thanks again for your thorough review and enriching feedback.

Best regards,
Javier Carrasco
