Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718E770825
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjHDSp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjHDSpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:45:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE649FF;
        Fri,  4 Aug 2023 11:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTmPQWY43c9fM1NHQKlYnBL8sRYAmHTij1BdPFAlLr8tMNJ2BReK/5Shh5vme8dW688kK4KJiv64Ir2G7W6YMDM42fACNEnwhMMWuqXyznIELwcg1dbAYVGuNkzYP66Fxpp84kImZs9UmMiSyL7VLSupYqPZMwU4dNbSFfB6OyAKzAy+0q5VwC33YOHDXXj+NefPO0t1uCU43A87RdpBAQu+ZWSH4APceZkUwXhru2P5+FsCeynaB091JvP7YNkg++Uuh80MAdxA6ASrXCsJDZ7DiGm1J5fYi4lYWHDbruXHvwK/+tHs1p8izepHjYOIN3CPWcd4YAp57YDlx9NV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti9xR8U7jJGjGO/fvzfrFv2o5EhhlrQItHV//l5lWvM=;
 b=PbyvtefriZg3HCzSW8wWlE7RHnmevo72hSuw4G2MhTrVsj7Mwm9Iw9xjT9+Dr0ycKsCwnhRjrRiD7bC0IAaXm0vbaJespAXYb2LB95JtW75QJ4Q8Nfmqc7s9FSntyQ690gli7SUXooMIVZhSlEaV/TrHq5TJsxyHfoViQDQH1V/OldO4NdtPsugKehIJ3cJIZje/KTF3pDc1z2Oynqo6ATNI0bOB763TFWX5sE6BHfjyosSbziO5NTish9RYn9keJ32l4rtq81ysquG5uxnQLJRWjKt3VfATuZCjQ5dNbFoCSvnDvaWXQEheH4OQeAXdgQ3dVlg1WyarIBr2oKlf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti9xR8U7jJGjGO/fvzfrFv2o5EhhlrQItHV//l5lWvM=;
 b=IhibGo9x5Ukm5zouAIOAVSv2stZ2ZRrb2SJf2KUdkFG2gsrs8g2tgvPcErQbhFWzQjTrwRPBvAHHSei41Gh2CVbRS+EQV3e18QGZpCd8HB5Rz2lvoJBx7wrQrAWGQvCKG83zILMKV1OUOdi1GVuOvWjENEQnBGigsHUTk84kPNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB6086.eurprd08.prod.outlook.com (2603:10a6:20b:29d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 18:45:43 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::9d1a:4539:a8f8:dd60]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::9d1a:4539:a8f8:dd60%7]) with mapi id 15.20.6652.022; Fri, 4 Aug 2023
 18:45:43 +0000
Message-ID: <caeddb66-6bac-3621-6a92-dbeca16261c3@wolfvision.net>
Date:   Fri, 4 Aug 2023 20:45:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/2] media: v4l2: map UVC_CT_ROLL_ABSOLUTE_CONTROL
Content-Language: en-US
To:     =?UTF-8?B?R2VyZ8WRIEvDtnRlbGVz?= <soyer@irl.hu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1691096157.git.soyer@irl.hu>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <cover.1691096157.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::11) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf2a5fe-7ab2-49f0-211d-08db951b01de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHV665sKP2Tfnq7mjqIlk2kX7ov1/9IBtfO1kwsa/30O8Fo4dGlyvuktAHPGu3uOxApcgoNuUAY5k9G/+L/T/v7DkoRsW3fNJ1bNNYqazQcUcdpoVAdKaupGiQM3dZ8JYz3IEbtnjiY5p1ScDgd2ssVkWGhILl6W7zKabrdxzJxs6zfwTNbSGNz5svUYcIFWFKJVOu+NXDTE4lAFE/ZeNh7TuK0mnsPc5+A4ynR1xJ8dtMuhvnJuv7qfY4oP/DdwZSaAh+1SKzM9eIUZ1edqsIFlqWmSc2uMalbcokr851M0lBeXbql29w1iUB3ryPSGfrT1ntm4F4yh8p0UnZjwqBG1DyJuJU+YXFxQPzfKlwWYo6kqgFjSTwfHkOPVdcSqYTqpEKymuq/1LWaJANitjaY7teHwqguIbn+4emS2YxeH8tuIVL5+e27FT2c909DxIbdscbSVUD2HhHJ2Zs2SkHVpqd5SOJUchr4jCwcRBIowl+u0ty/N/p499tCAx5+1TACJadVBRVapuCqxRfOmfQqVfe9io8Cfig1hmNoV6IDm4VQDPpqD1i7Cim4tiZsSeDJ5U0p59MzH+KWNX+939rKf+o6n65a2znVcoCqLxeSBtTUd2YNT2YIu3J46bjqPMDvgNSoq7iBb0dNL9BxwTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39850400004)(186006)(451199021)(1800799003)(44832011)(66476007)(66946007)(66556008)(4326008)(2906002)(38100700002)(2616005)(53546011)(6506007)(110136005)(86362001)(6512007)(31696002)(478600001)(36756003)(6486002)(8936002)(8676002)(5660300002)(41300700001)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ZvVFpRdGtqVEhya25YOWJ5Q2tHcURWTnFSaWI3UDNkSWFIMkZSS1gwOGdY?=
 =?utf-8?B?RXMxdmdQSUcwZHhmOVRUcDFyUlgvMUk0QVc0eTRFRVdBQ1ZaQWhqNnNiRXBY?=
 =?utf-8?B?cVVnTzBHTWp3dDlTdUMwWGF4dFhoQ1ZHZWtTOHc1NnpJL2VwMkRaTEljaVgy?=
 =?utf-8?B?ZmlLWjlBNVNCY2VlYUNYRUthcFFvY0RNQi9CZnlYbVBHZWt1clhkZGFrVWFK?=
 =?utf-8?B?Nmw1cTFoK0tpYjJHajVsa3lsNmg2QkhwdEFjUVRLK3MrbXIwODZaWkE0THEx?=
 =?utf-8?B?Z2Y2QUdYM2pCb0xZR3dxS1lkUzJ3MVlSdXkyWTZsWm12UEVqbkhJYWFLa1NR?=
 =?utf-8?B?Q281Yk1UWnNCR3pvVGpFdlBGbGJUVWtBSUdmNU14ZEhsczJkWmhwREFNb0Y4?=
 =?utf-8?B?M2NCaFRhc04wbGp6blJDbDFkTnZJWTZBeXVLZHNPSXJGM21zNmFnTzhwTnZo?=
 =?utf-8?B?SFRZckttR3FWU05VRDVvSnVvZFNRSHhqcnZNWjRvejN5Z2UxcFd0UkxOSjg4?=
 =?utf-8?B?WDloNVJTVXdnOEpkWlY3c1VPODB0bkdaWFlreUF4T2FsdWdjdi9uZ0pkWjhY?=
 =?utf-8?B?MlJteVR1YitZSjhLR3N6SEphZEpDaWZZaE1GL2RQVG1kcUl6ZnpKT3Iyekc0?=
 =?utf-8?B?Zk9ncFFzVFEvR2NTdkozODl5S1YwYTZMa0xhSlFHbXEzQUwzT3dNZGNvSnRl?=
 =?utf-8?B?K3ViVEhGMkdTWGI1MmEyaWJUN05mdTVPanpnRlpjaDFFR29EZksvak9uNlBO?=
 =?utf-8?B?ZTVJV2F0Mnd5b2p0MmIwQThPL3dBR3dya0lEZmVZMGhRZk80WHVOS29xL3pZ?=
 =?utf-8?B?TDcxNjAyS01uOThnM1F6VFFqeTZ0Tm00Y1pPMzl6azhOaW9tTHdIOEs0emk2?=
 =?utf-8?B?Ujl6OEZhOGtpNmYxMk1uVTNWYWxJKzFidS8zNzBRWGIvUGl2Zm1FZnFrNGYz?=
 =?utf-8?B?V3RPK01xLzVncERKb010SkJKQVM0OEtnWmVxQVhPbVBBU0MwMjdEeGdraFhn?=
 =?utf-8?B?QnBjQ3VzNkJYN1JYY0pCanp6MnUrNi9pR2Z0RDJVcWlpYkR5bzhiaE9Gckhi?=
 =?utf-8?B?T09ZaGZoUmhHU2RLWjc5L0VrUHE5ejE2VDZwYXgxTk45SW8zTXk4eVlMQ0Nn?=
 =?utf-8?B?VWorWnpFYW56ZWN3UGdDcHFhRXErY2lNNGlPWUdBUXprcEttUFJKTG9UNEc0?=
 =?utf-8?B?QVZoZUZXV0xCNE5HMGVCRFdDNTE5dlVtUU1IQkhCUzUwdzF1TFVBV1FFcnM0?=
 =?utf-8?B?bVNlUTF3cXBwRmh1MVdZWnNRNVRiMEtKZmlCdmx5K0dEQUlKbllONjVaM3p3?=
 =?utf-8?B?NC9laEZ2eDdxbTBQODc4N0hCd2s0NXh5UExJYWlnd0s0WENrMzg0Z0o5NTQ3?=
 =?utf-8?B?NHRPUGxWZ2lRNVZpVG4ySVIrdytPbmNRMS9zWk5GQ0lwaGNzdzdLVzhrK1pS?=
 =?utf-8?B?cWlHdk9LWCszU0dMNGF0NWN4OENhUHFFS1dQODRCWkZvTC8zTWdxcmRBYVV4?=
 =?utf-8?B?Y0xzUWdqcWZ3ZFFKOTF5emI5cndBMlRXUWxTVmNEdmc1ZzV0MzQ5cXdPaUpC?=
 =?utf-8?B?T3ZoSWo1aXVaY294OWlmQ3JIaGRDSTkwK0ZIQldyaldrSlVIQnhFRmdyN3Jy?=
 =?utf-8?B?akNVVUVHS2NjWU1ScHpZdXZyM0UyaDVUcmFZU1ZnYVFjVU5IbWxvaElXUlY1?=
 =?utf-8?B?eVFxSGN3UzRNYzBKN25IVVQ4RE82Q2Q3Z2FNZU1qWHhKY2FXT3RBR0Q2V1lP?=
 =?utf-8?B?UzJVTVUzdDIyNlBTR054V1ZUbkl2NytHeW1EZS9QR1FONWw5ZHFoZk90aEoy?=
 =?utf-8?B?UUN2L3Y1bzg5TmdUSy9LdCsxWDhiZmhTa09tMmlqZjhNVm9ucXBMNjNlZzQr?=
 =?utf-8?B?SFFiVTU5UDQxR0dLSTNXV1F0OWVUTDBRaWpXaTJRblVUZVNhVlozK1VxRjdC?=
 =?utf-8?B?MEVtYkYxWU16VTJHL21lL0h5dk01a1ZPeDlDbE9hcS9FbUg2UXk5ZlJRUlYz?=
 =?utf-8?B?L3VZTUhBdkwzVEEzaVliamZ6R0xUV0IrWmpCZXBGeTRKUUMrSHFFcGx5WU40?=
 =?utf-8?B?cVkwU0hybFFrRnNiVi8zNm9DUmtvcTdWeU5uSU9QOGw0RGtDSjZyQnkyVGV0?=
 =?utf-8?B?Y3NrUGtkaHN4ME11VXFoR3F6SmVYZ25aclBKNENPZTZHVmtpaDA3NlVtdjNQ?=
 =?utf-8?B?a0JoYWdBUkYvazEvQmhvc3VUakFqYkRaN2ZBdHAwNHF5T1hzVENmZjNKYS9s?=
 =?utf-8?Q?FxcHoJojb5v6bcaxVbTilWJytzeZEun5WF8MEwX6xU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf2a5fe-7ab2-49f0-211d-08db951b01de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:45:43.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vreCLgL7dDglaP8HVUCxmcrSGtjPEfgG5q3fc29lF8iKetsXIAdWALhweRF9qmE82T0wpBwLvnhZfLKgbMZgbt3V2IJoClAz2SAJ/04OPsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6086
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gergő,

Interesting work! I would guess that there are a lot of cameras with an
accelerometer or gyroscope that could report the rotation.

On 8/3/23 23:28, Gergő Köteles wrote:
> Hi,
> 
> Logitech Streamcam can be mounted in 'portrait mode' as well.
> It reports the current roll (-90, 0, 90, 180) with
> UVC_CT_ROLL_ABSOLUTE_CONTROL.
> 
> This RFC defines V4L2_CID_ROLL_ABSOLUTE, and maps
> UVC_CT_ROLL_ABSOLUTE_CONTROL to make it available to
> userspace.
> Then, the userspace can rotate the stream based on the roll.

Should we also discuss pitch and yaw while we are at it?

As far as I know there are controls to set pan and tilt of a PTZ camera,
but there are no controls that report those angles.

> Is it better to use V4L2_CID_CAMERA_SENSOR_ROTATION for this?

IMHO that would make sense.

Best regards,
Michael

> The value set matches that control.
> If yes, is it worth mapping UVC_CT_ROLL_ABSOLUTE_CONTROL to
> V4L2_CID_CAMERA_SENSOR_ROTATION for this camera only?
> 
> Any feedback is greately appreciated.
> 
> 
> Gergő Köteles (2):
>   media: v4l2: ctrls: Add ROLL_ABSOLUTE control
>   media: v4l2: map UVC_CT_ROLL_ABSOLUTE_CONTROL
> 
>  .../userspace-api/media/v4l/ext-ctrls-camera.rst         | 5 +++++
>  drivers/media/usb/uvc/uvc_ctrl.c                         | 9 +++++++++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                | 1 +
>  include/uapi/linux/v4l2-controls.h                       | 2 ++
>  4 files changed, 17 insertions(+)
> 
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
