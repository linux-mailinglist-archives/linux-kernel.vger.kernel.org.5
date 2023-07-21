Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA5975BE38
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGUGFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjGUGFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:05:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E702630CF;
        Thu, 20 Jul 2023 23:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFAQiQp/8w63lvaZZMPPHTjL0+1ZifKKmggts7V+6bdyCVL1QRjUCG5+RuxW32YI1fQzgyPqpzu39RPJTXiBbxC3S37xj4/ty14NL6mYFBaWxChq5CJsPBaCoVqmo49RqhynOETyq32W5eCnts4CCzJUAKR/o/aKB8VHKq81j9V11bA27e+qAQJGz99OdzwTqo41+Sp2ktlO1bpnGJ39ux/T2jxz8BUKbKtqPuwGdmCHi8zFvdCJO0JLHpKY5d7w/KPXZX0yYJBliboaHX3Ln1mpUooNjzzapCzuF1y7vgbWiUuW9DWuOev8uvSx6q4SHyITC2moTADJi9+3aANong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG+JZmChyT7qH3gEPVt/WiI0SiHl+ldY58PO90Jp/jE=;
 b=oI79JrSQow1T47NYMm6KEA6JKEk3g7GzodKzUdX5Q6x3i9dKDVR/3wj9/fX64bahatMJ9UQhtghUDgyz5Tnm6kr2EOIvFd+RLyheRFbOpbwuocg/2BaZdKgBhTlTm6bMukE+KVpcICMnIKzP87Vp9tLK12rHdN5hGTZpTfKkJ53t9+IuXho4PmIVhA0T4J8kuSy/js8yfSXB/JnHM3KcmM3ZBnXigkkMYt/qKGX30YCo4BLNKSfuQ3mCMTYuVn2LaJi3jQ3mU6uAJG7v9PvsswX6f+Q41cj4QqnGMND6kiPUQ57G0ZRl13oEjSI5U2rYhqJQ9WYTRYk/VgU8yDyhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG+JZmChyT7qH3gEPVt/WiI0SiHl+ldY58PO90Jp/jE=;
 b=HZADXYeviJN9XqyBu8e50Gz31YIwBVcB4dHStuDxDXZaEWb5u/g27fSuGj0TgQfpeSzkuinmE6tZVs/6ad2Bv8GZKaCPaozyodQc8wA8Dj+2Zj+BUxi+jyHiFB2FkSrlb2iVAsiP31l66BnPMh+sotGdKDTiKLumjHdAGCGdajE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BY1PR03MB7262.namprd03.prod.outlook.com (2603:10b6:a03:522::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 06:03:43 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 06:03:43 +0000
Message-ID: <a773247a-76cb-2132-884b-e88378827180@synaptics.com>
Date:   Fri, 21 Jul 2023 14:03:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 1/9] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     linux-media@vger.kernel.org, ayaka <ayaka@soulik.info>,
        Brian.Starkey@arm.com, boris.brezillon@collabora.com,
        frkoenig@chromium.org, hans.verkuil@cisco.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, kernel@collabora.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, narmstrong@baylibre.com, nicolas@ndufresne.ca,
        sakari.ailus@iki.fi, stanimir.varbanov@linaro.org,
        Helen Koike <helen.koike@collabora.com>
References: <20230206043308.28365-1-ayaka@soulik.info>
 <20230206043308.28365-2-ayaka@soulik.info>
 <20230713102656.qmrtd3jscu3fualy@chromium.org>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <20230713102656.qmrtd3jscu3fualy@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::30) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BY1PR03MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bfc125-fcc8-49c9-7d3c-08db89b03c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiNusPnqiFNyB8/MuLltrMooRxAAdqn+UpbvSeHWGJySs2WGXCgoNo2Lrq2nG1njO+SJ6yvEVMlgaUbaxfy+8vtcOTUp4XilhkYHUN/jtlZn71IH5ZwH07Crow7EL3ZXQqGnWtJ0ylCz23Yd24LZUusf2h7oLWi4I/RWf30KnyjQWPY06KOPEoZsTa7pqisa34unF5C5EoB18rKRlA5I6Z8VTIHPqrG/mqE2VGZgFB+IPOeiHFfSnu8r0jzixoiuBHpbUDXqkvUWOmgQyB2W7KabAraZ+qNBmM16USQ7+iFAtnGt5IR/NVb4XX1/RxjLR87Y/98wzFzamE4sVcd7ZKli827IGCa8uC3y/TArBacwt9uUka7/EKXqqz+hl1kGgt0fPRJ1N6IVApGJ1IfhyJwXRWvNw7LxuOWy7kvwiegMQI4Io21L4zfwBGHsvjMYGaPdc0LB0volVj0TJRgT3PLs1hrFQ/H5wUyn+v8fw5XCc7dw8msnuqX1V8B5doGAOziPW5H6Su579PhrUyqA6B9hIKccquQTvIBtfEI8oM3srdERRAaU+rP76KwEWMs81Vru1SYifZFxlLO1XqdMUI+cmISPaaZJunaBOWPtdQKKlOQZhpukA0ARdiXDhnv88DpSttXPCazwDZg00YOtbIjpuNSaf9NF0Gz65J52uG/XYZiv+6EeYxK9TsCqUxUH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(31686004)(54906003)(478600001)(6512007)(6486002)(6666004)(52116002)(36756003)(86362001)(31696002)(83380400001)(66476007)(66556008)(4326008)(2906002)(30864003)(2616005)(6506007)(53546011)(186003)(66946007)(38100700002)(26005)(316002)(6916009)(38350700002)(8936002)(41300700001)(8676002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUkvNU5ZUUhPZGEzREY4MFc2YTVOZHRXQ1JaRlVIVTRLWU5qMDlsR1kvRlNn?=
 =?utf-8?B?V1IxdkRXbU5jaG95SWlad01NZnVTWXFEbytFNHFVY1Zjc3lPc3FJR3lNRUZs?=
 =?utf-8?B?WWVoVld4djhER2c4NGlMMXdiNHJ3UDBOZWp4ZnBmellieTFUbVhoV1JIUEpX?=
 =?utf-8?B?cjFYbEZIa0twUENNZnRMcWxLVHdkSmNOMzBBT1Jic3hCYlhNNVhwNVRwY1RJ?=
 =?utf-8?B?eUNWM1VudXdvYWoxOHBNVEFXWkdVQzdIN0pRT1JzYXIwRTVRQmJwdy9sd0oz?=
 =?utf-8?B?UFM2bjFCQWVPYVF0b0dXczJCM01KaFBGS3BJWmVCOVhEY2Z6Y2F6NkRmRXor?=
 =?utf-8?B?OENxYWFBQ3NhQkpsU1JpUG1WZGpSTEpvQWlkNllnK1ZIN2dUQlh1QVdJdjBT?=
 =?utf-8?B?TCt0RmVyN0I2WGJOM25tajFZZDMwZnozWUZXdzhyTXRpOEphWlhxdEh1cGhk?=
 =?utf-8?B?WitMcGlOMm5CZWxIMFRvY3NyY1RnY1k4blh0RkpPaGV1Ui9EMlphZ1lJZ2tB?=
 =?utf-8?B?cTI4c0dWZVNwTFdnRkFnaHI0M05WdHRXU0dYKzUzakFGSkhxZjYxMlpiQ2F4?=
 =?utf-8?B?SFloazVUU0FRMC9rS1VLdFQzWDJhZm5sQVZ3RTdKQ2s2OG9mWVMwYU9od3Zz?=
 =?utf-8?B?YnFXOVErc2FmekdtM2gvcXFEZGR6NU90ekM1NHhadmo3RTEzZ0UxU3RwSUQ3?=
 =?utf-8?B?cG1kWG9wL1VqeUtWYnhnMmllQnVqV0dmYjNpaFFtckNjK3FVMHVJZG1tZFpW?=
 =?utf-8?B?Z3ZEd3B4Mys4cVNiRlV0ZndnMW5xMTh6TncwZWIxRG1Zano5alV4RXo3VGwy?=
 =?utf-8?B?akpQYjNlQ3Z6ckh4MjRWalFTMDFXa1BiZEVXKzhwYXlGRU9ZUk10QXJGbHpL?=
 =?utf-8?B?MFFra2luZEFTZjJ0YmNVZ3R2VG9RNXpaaHFjK21CaEZhZENNVnpKTHA5Wk9R?=
 =?utf-8?B?bEd1L0RZSGtFWS9sMENoODR2dHlwclpGUkZyVTRhVUYrV3p4V04ya3JoTlVQ?=
 =?utf-8?B?UmVON1h2UUdqS3BpMFNmSjlUWmk3TGlqVDliWDczcXV0NURHRm1EQ3dqK1hR?=
 =?utf-8?B?cFk0eUZ4ZjZubGJDbWNiSGlPZUExS0RoVUJscmFVMUtLblU4RExTc0c2WDhP?=
 =?utf-8?B?aDlpMlpGdGtOUE1CcDV0VHI4MkxkbzZVUENyWUk2STFScXBXSzF0aEZKNVJR?=
 =?utf-8?B?WkdtYm0xYWE1aTN6LzAySnVsUUVaYXp1OU5GRmVnV1dsRCtkNFNEY1V0OWZU?=
 =?utf-8?B?ZE1VTExnM0JBcGtZNVhpRkZUMm5mMnFoWUxJT0lPSDNmU2p2VFV2RmE1MXdB?=
 =?utf-8?B?OUFtLzJPdGhKM1M5SFhmNWxUNlFYZWN3ZW9yZjF6MVAydmdXOHp0eU1LVisy?=
 =?utf-8?B?TDJjdkg4YUxFZjhWMG91ZjJGNmRPZTZjZ2xHc0xGb0VMWnFwNUE2WVpwZkVG?=
 =?utf-8?B?SHI2Y29DMUU1RDhUQWtHSW1QRDc5dC83eEt1am9pa1graG1mQzFMeWRaSXdR?=
 =?utf-8?B?b21zZThhOWNrQTRYMUdoSUg3YjVVY3BNd0E0ZnJFd20ySCtJTnQxS0JsSHF3?=
 =?utf-8?B?YzV0R1VuRXRlRHVGajZnc2FOTWZ4NnB3OS8yOUpleGpKOTRoR0pvUGhoZTlk?=
 =?utf-8?B?U3lpSUFOWHgzcU5DS1pOM0NvNWZTZzBTWGhza2JpQWdrc3g1OHVHK2NyU1k3?=
 =?utf-8?B?WUVFbU1LaWV1WlhZeUpDVGQ0cDU5VjJzN0pEWUZOd2cxQlNJS015NHlpNndV?=
 =?utf-8?B?dlFrMW1oK0lLTzNGOUlCdkZ0eGl5Z3RmL1g2bXh2Z2NqWC91bEVQazdCSDZG?=
 =?utf-8?B?M2czQnM3S3kxYkZxNE5xTUtpUk9QMFpPeEZRZFlma01GMGlvVm0vQk9yYTl0?=
 =?utf-8?B?WHhQaWlzaEZ1TVFuaEREalZsK0ZRandRRExMSjhNbVpHSWd1eVdMbHhBOFV6?=
 =?utf-8?B?TndHTzVGVGpaVHBSSGZIVzV2Zko0NmUvN0hZUUpCeXNZRmszNmt0bkx2RkZM?=
 =?utf-8?B?czJIWEVoMFFFcmtTR3BGUFY0RlNxRWM3NUJkZE1icU5iODhldjlYRlpRdytx?=
 =?utf-8?B?dFFCaWVDUjNqOW1JdUNabXF5TTI3Ry9TVDg3Njh1dlV4MEM2VjVlNmhFSCtu?=
 =?utf-8?Q?xfB/gIQ4V0P02xuJ8IQbdolXU?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bfc125-fcc8-49c9-7d3c-08db89b03c39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 06:03:42.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+k9wckOmf/o+omEGWyceebQ61Rbbo+jLELI3DvZ8+swyQiKOxdcbdbQ15iWFDZ9boY2q0Nxj2hwh64l6hdzyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7262
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/23 18:26, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Mon, Feb 06, 2023 at 12:33:00PM +0800, ayaka wrote:
>> From: Randy Li <ayaka@soulik.info>
>>
>> This is part of the multiplanar and singleplanar unification process.
>> v4l2_ext_pix_format is supposed to work for both cases.
>>
>> We also add the concept of modifiers already employed in DRM to expose
>> HW-specific formats (like tiled or compressed formats) and allow
>> exchanging this information with the DRM subsystem in a consistent way.
>>
>> Note that only V4L2_BUF_TYPE_VIDEO_[OUTPUT,CAPTURE] are accepted in
>> v4l2_ext_pix_format, other types will be rejected if you use the
>> {G,S,TRY}_EXT_PIX_FMT ioctls.
>>
>> New hooks have been added to v4l2_ioctl_ops to support those new ioctls
>> in drivers, but, in the meantime, the core takes care of converting
>> {S,G,TRY}_EXT_PIX_FMT requests into {S,G,TRY}_FMT so that old drivers can
>> still work if the userspace app/lib uses the new ioctls.
>>
>> The conversion is also done the other around to allow userspace
>> apps/libs using {S,G,TRY}_FMT to work with drivers implementing the
>> _ext_ hooks.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>> Signed-off-by: Randy Li <ayaka@soulik.info>
>> ---
>>
>> Changes in v7:
>> - use the resevered fields in v4l2_fmtdesc to store the modifier for format
>>    enumerate.
>> - Dropping the old ioctl() calling new interfaces adapter.
> 
> Why?
> 
> We need backwards compatibility with the legacy API, but requiring
> drivers to implement both will add even more boiler plate code to the
> drivers and potential for each driver to have a buggy implementation in
> its own way. (From my experience, every driver already handles the
> TRY_FMT/S_FMT operations in its own slightly buggy way.)
Then we would continues on dirtying the fourcc namespace. I think the 
whole point of this extend API is to trying not squeeze those tiling 
formats into a small 32bits namespace.
> 
> What we probably don't need is core code for making old drivers
> automatically support the new API (i.e. the other way around).
Make this wrapper layer in kernel to save application from keepping the 
legacy code. I really want people dropping a v4l2 fourcc pixel format, 
using drm pixel formats instead.

The rest fixup would be considered in the new version of this series.
  We can
> have the drivers modified to the new API whenever one needs to use the
> new features with the old hardware. (And possibly other modernization of
> the driver code could happen at the same time.)
> 
>> - Refresh the patch
>> Changes in v6:
>>   The main change here was fixing the conversion, so planes reflects color planes,
>>   and to implement this properly I made major refactors compared to the previous
>>   version.
>> - struct v4l2_plane_ext_pix_format removed, using struct v4l2_plane_pix_format instead (Tomasz)
>> - refer to drm_fourcc.h in struct v4l2_ext_pix_format docs (Hans)
>> - reorder colorimetry fields in struct v4l2_ext_pix_format (Hans)
>> - do not set Ext ioctls as valid for vid_out_overlay (Tomasz)
>> - refactor conversion functions, so planes are color planes (Tomasz)
>> - Don't explicitly check for e->modifier != 0 in v4l2_ext_pix_format_to_format() (Tomasz)
>> - Use "ef" for extended formats in the framework for consistency (Tomasz)
>> - Handle xfer_func field in conversions (Tomasz)
>> - Zero reserved fields in v4l_s_ext_pix_fmt() and v4l_try_ext_pix_fmt() (Tomasz)
>> - Refactor format functions to use v4l_fmt_ioctl_via_ext()
>> - Several fixes/refactoring/changes
>> - Remove EXT API for touch devices
>>
>> Changes in v5:
>> - change sizes and reorder fields to avoid holes in the struct and make
>>    it the same for 32 and 64 bits
>> - removed __attribute__ ((packed)) from uapi structs
>> - Fix doc warning from make htmldocs
>> - Updated commit message with EXT_PIX prefix for the ioctls.
>>
>> Changes in v4:
>> - Use v4l2_ext_pix_format directly in the ioctl, drop v4l2_ext_format,
>> making V4L2_BUF_TYPE_VIDEO_[OUTPUT,CAPTURE] the only valid types.
>> - Add reserved fields
>> - Removed num_planes from struct v4l2_ext_pix_format
>> - Removed flag field from struct v4l2_ext_pix_format, since the only
>>    defined value is V4L2_PIX_FMT_FLAG_PREMUL_ALPHA only used by vsp1,
>>    where we can use modifiers, or add it back later through the reserved
>>    bits.
>> - In v4l2_ext_format_to_format(), check if modifier is != MOD_LINEAR &&
>>    != MOD_INVALID
>> - Fix type assignment in v4l_g_fmt_ext_pix()
>> - Rebased on top of media/master (post 5.8-rc1)
>>
>> Changes in v3:
>> - Rebased on top of media/master (post 5.4-rc1)
>>
>> Changes in v2:
>> - Move the modifier in v4l2_ext_format (was formerly placed in
>>    v4l2_ext_plane)
>> - Fix a few bugs in the converters and add a strict parameter to
>>    allow conversion of uninitialized/mis-initialized objects
>> ---
>>   drivers/media/v4l2-core/v4l2-dev.c   |  13 +
>>   drivers/media/v4l2-core/v4l2-ioctl.c | 357 ++++++++++++++++++++++++++-
>>   include/media/v4l2-ioctl.h           |  28 +++
>>   include/uapi/linux/videodev2.h       |  46 +++-
>>   4 files changed, 438 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
>> index 397d553177fa..cfe90bfd47f1 100644
>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>> @@ -615,6 +615,10 @@ static void determine_valid_ioctls(struct video_device *vdev)
>>                               ops->vidioc_g_fmt_vid_out_mplane ||
>>                               ops->vidioc_g_fmt_vid_out_overlay)))
>>                        __set_bit(_IOC_NR(VIDIOC_G_FMT), valid_ioctls);
>> +             if ((is_rx && ops->vidioc_g_ext_pix_fmt_vid_cap) ||
>> +                 (is_tx && ops->vidioc_g_ext_pix_fmt_vid_out)) {
>> +                     __set_bit(_IOC_NR(VIDIOC_G_EXT_PIX_FMT), valid_ioctls);
>> +             }
>>                if ((is_rx && (ops->vidioc_s_fmt_vid_cap ||
>>                               ops->vidioc_s_fmt_vid_cap_mplane ||
>>                               ops->vidioc_s_fmt_vid_overlay)) ||
>> @@ -622,6 +626,11 @@ static void determine_valid_ioctls(struct video_device *vdev)
>>                               ops->vidioc_s_fmt_vid_out_mplane ||
>>                               ops->vidioc_s_fmt_vid_out_overlay)))
>>                        __set_bit(_IOC_NR(VIDIOC_S_FMT), valid_ioctls);
>> +
>> +             if ((is_rx && ops->vidioc_s_ext_pix_fmt_vid_cap) ||
>> +                 (is_tx && ops->vidioc_s_ext_pix_fmt_vid_out)) {
>> +                     __set_bit(_IOC_NR(VIDIOC_S_EXT_PIX_FMT), valid_ioctls);
>> +             }
>>                if ((is_rx && (ops->vidioc_try_fmt_vid_cap ||
>>                               ops->vidioc_try_fmt_vid_cap_mplane ||
>>                               ops->vidioc_try_fmt_vid_overlay)) ||
>> @@ -629,6 +638,10 @@ static void determine_valid_ioctls(struct video_device *vdev)
>>                               ops->vidioc_try_fmt_vid_out_mplane ||
>>                               ops->vidioc_try_fmt_vid_out_overlay)))
>>                        __set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
>> +             if ((is_rx && ops->vidioc_try_ext_pix_fmt_vid_cap) ||
>> +                 (is_tx && ops->vidioc_try_ext_pix_fmt_vid_out)) {
>> +                     __set_bit(_IOC_NR(VIDIOC_TRY_EXT_PIX_FMT), valid_ioctls);
>> +             }
>>                SET_VALID_IOCTL(ops, VIDIOC_OVERLAY, vidioc_overlay);
>>                SET_VALID_IOCTL(ops, VIDIOC_G_FBUF, vidioc_g_fbuf);
>>                SET_VALID_IOCTL(ops, VIDIOC_S_FBUF, vidioc_s_fbuf);
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index 87f163a89c80..52b77a968bb3 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -18,8 +18,10 @@
>>
>>   #include <linux/v4l2-subdev.h>
>>   #include <linux/videodev2.h>
>> +#include <drm/drm_fourcc.h>
>>
>>   #include <media/media-device.h> /* for media_set_bus_info() */
>> +
>>   #include <media/v4l2-common.h>
>>   #include <media/v4l2-ioctl.h>
>>   #include <media/v4l2-ctrls.h>
>> @@ -34,6 +36,11 @@
>>
>>   #define is_valid_ioctl(vfd, cmd) test_bit(_IOC_NR(cmd), (vfd)->valid_ioctls)
>>
>> +#define V4L2_IS_CAP_MULTIPLANAR(vdev)        (vdev->device_caps & \
>> +                                      (V4L2_CAP_VIDEO_CAPTURE_MPLANE | \
>> +                                      V4L2_CAP_VIDEO_OUTPUT_MPLANE | \
>> +                                      V4L2_CAP_VIDEO_M2M_MPLANE))
>> +
>>   struct std_descr {
>>        v4l2_std_id std;
>>        const char *descr;
>> @@ -353,6 +360,27 @@ static void v4l_print_format(const void *arg, bool write_only)
>>        }
>>   }
>>
>> +static void v4l_print_ext_pix_format(const void *arg, bool write_only)
>> +{
>> +     const struct v4l2_ext_pix_format *ef = arg;
>> +     unsigned int i;
>> +
>> +     pr_cont("type=%s, width=%u, height=%u, format=%c%c%c%c, modifier %llx, field=%s, colorspace=%d, ycbcr_enc=%u, quantization=%u, xfer_func=%u\n",
>> +             prt_names(ef->type, v4l2_type_names),
>> +             ef->width, ef->height,
>> +             (ef->pixelformat & 0xff),
>> +             (ef->pixelformat >>  8) & 0xff,
>> +             (ef->pixelformat >> 16) & 0xff,
>> +             (ef->pixelformat >> 24) & 0xff,
>> +             ef->modifier, prt_names(ef->field, v4l2_field_names),
>> +             ef->colorspace, ef->ycbcr_enc,
>> +             ef->quantization, ef->xfer_func);
>> +     for (i = 0; i < VIDEO_MAX_PLANES && ef->plane_fmt[i].sizeimage; i++)
>> +             pr_debug("plane %u: bytesperline=%u sizeimage=%u\n",
>> +                      i, ef->plane_fmt[i].bytesperline,
>> +                      ef->plane_fmt[i].sizeimage);
>> +}
>> +
>>   static void v4l_print_framebuffer(const void *arg, bool write_only)
>>   {
>>        const struct v4l2_framebuffer *p = arg;
>> @@ -940,7 +968,9 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
>>        switch (type) {
>>        case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>                if ((is_vid || is_tch) && is_rx &&
>> -                 (ops->vidioc_g_fmt_vid_cap || ops->vidioc_g_fmt_vid_cap_mplane))
>> +                 (ops->vidioc_g_fmt_vid_cap ||
>> +                  ops->vidioc_g_ext_pix_fmt_vid_cap ||
>> +                  ops->vidioc_g_fmt_vid_cap_mplane))
>>                        return 0;
>>                break;
>>        case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> @@ -953,7 +983,9 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
>>                break;
>>        case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>                if (is_vid && is_tx &&
>> -                 (ops->vidioc_g_fmt_vid_out || ops->vidioc_g_fmt_vid_out_mplane))
>> +                 (ops->vidioc_g_fmt_vid_out ||
>> +                  ops->vidioc_g_ext_pix_fmt_vid_out ||
>> +                  ops->vidioc_g_fmt_vid_out_mplane))
>>                        return 0;
>>                break;
>>        case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>> @@ -1082,6 +1114,203 @@ static void v4l_sanitize_format(struct v4l2_format *fmt)
>>        }
>>   }
>>
>> +static void
>> +v4l2_ext_pix_format_to_pix_format(const struct v4l2_ext_pix_format *ef,
>> +                               struct v4l2_pix_format *pix)
>> +{
>> +     unsigned int i;
>> +
>> +     pix->width = ef->width;
>> +     pix->height = ef->height;
>> +     pix->field = ef->field;
>> +     pix->flags = V4L2_PIX_FMT_FLAG_SET_CSC;
>> +     pix->colorspace = ef->colorspace;
>> +     pix->ycbcr_enc = ef->ycbcr_enc;
>> +     pix->priv = V4L2_PIX_FMT_PRIV_MAGIC;
>> +     pix->quantization = ef->quantization;
>> +     pix->pixelformat = ef->pixelformat;
>> +     pix->bytesperline = ef->plane_fmt[0].bytesperline;
>> +     pix->sizeimage = ef->plane_fmt[0].sizeimage;
>> +     for (i = 1; i < VIDEO_MAX_PLANES && ef->plane_fmt[i].sizeimage; i++)
>> +             pix->sizeimage += ef->plane_fmt[i].sizeimage;
>> +}
>> +
>> +static void
>> +v4l2_ext_pix_format_to_pix_mp_format(const struct v4l2_ext_pix_format *ef,
>> +                                  struct v4l2_pix_format_mplane *pix_mp)
>> +{
>> +     const struct v4l2_format_info *info =
>> +                                     v4l2_format_info(ef->pixelformat);
>> +     unsigned int i;
>> +
>> +     pix_mp->width = ef->width;
>> +     pix_mp->height = ef->height;
>> +     pix_mp->field = ef->field;
>> +     pix_mp->flags = V4L2_PIX_FMT_FLAG_SET_CSC;
>> +     pix_mp->colorspace = ef->colorspace;
>> +     pix_mp->ycbcr_enc = ef->ycbcr_enc;
>> +     pix_mp->quantization = ef->quantization;
>> +     pix_mp->pixelformat = ef->pixelformat;
>> +
>> +     /* This is true when converting to non-M-variant */
>> +     if (info && info->mem_planes == 1) {
>> +             pix_mp->plane_fmt[0] = ef->plane_fmt[0];
>> +             pix_mp->num_planes = 1;
>> +             for (i = 1; i < VIDEO_MAX_PLANES && ef->plane_fmt[i].sizeimage; i++)
>> +                     pix_mp->plane_fmt[0].sizeimage += ef->plane_fmt[i].sizeimage;
>> +
>> +             return;
>> +     }
>> +
>> +     for (i = 0; i < VIDEO_MAX_PLANES && ef->plane_fmt[i].sizeimage; i++)
>> +             pix_mp->plane_fmt[i] = ef->plane_fmt[i];
>> +     pix_mp->num_planes = i;
>> +}
>> +
>> +/*
>> + * v4l2_ext_pix_format_to_format - convert to v4l2_ext_pix_format to v4l2_format
>> + *
>> + * @ef: A pointer to struct struct v4l2_ext_pix_format to be converted.
>> + * @f: A pointer to struct v4l2_format to be filled.
>> + * @is_mplane: Bool indicating if multiplanar API should be used in @f.
>> + *
>> + * If pixelformat should be converted to M-variant, change ef->pixelformat
>> + * to the M-variant before calling this function.
>> + */
>> +static void v4l2_ext_pix_format_to_format(const struct v4l2_ext_pix_format *ef,
>> +                                       struct v4l2_format *f, bool is_mplane)
>> +{
>> +     memset(f, 0, sizeof(*f));
>> +
>> +     if (ef->modifier != DRM_FORMAT_MOD_LINEAR &&
>> +         ef->modifier != DRM_FORMAT_MOD_INVALID)
>> +             pr_warn("Modifiers are not supported in v4l2_format, ignoring %llx\n",
>> +                     ef->modifier);
>> +
>> +     if (!is_mplane) {
>> +             f->type = ef->type;
>> +             v4l2_ext_pix_format_to_pix_format(ef, &f->fmt.pix);
>> +             return;
>> +     }
>> +
>> +     if (ef->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
>> +             f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>> +     else
>> +             f->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
>> +
>> +     v4l2_ext_pix_format_to_pix_mp_format(ef, &f->fmt.pix_mp);
>> +}
>> +
>> +static void
>> +v4l2_pix_format_to_ext_pix_format(const struct v4l2_pix_format *pix,
>> +                               struct v4l2_ext_pix_format *ef)
>> +{
>> +     const struct v4l2_format_info *info =
>> +                                     v4l2_format_info(pix->pixelformat);
>> +     unsigned int i;
>> +
>> +     ef->width = pix->width;
>> +     ef->height = pix->height;
>> +     ef->field = pix->field;
>> +     ef->colorspace = pix->colorspace;
>> +     ef->ycbcr_enc = pix->ycbcr_enc;
>> +     ef->quantization = pix->quantization;
>> +     ef->xfer_func = pix->xfer_func;
>> +     if (pix->flags)
>> +             pr_warn("Ignoring pixelformat flags 0x%x\n", pix->flags);
>> +
>> +     /* We assume M-variants won't be used in this function */
>> +     ef->pixelformat = pix->pixelformat;
>> +
>> +     ef->plane_fmt[0].bytesperline = pix->bytesperline;
>> +     ef->plane_fmt[0].sizeimage = pix->sizeimage;
>> +
>> +     if (!info)
>> +             return;
> 
> Should we print a warning in case of !info?
> 
>> +
>> +     for (i = 1; i < info->comp_planes; i++) {
>> +             ef->plane_fmt[i].bytesperline = pix->bytesperline / info->hdiv;
>> +             ef->plane_fmt[i].sizeimage = ef->plane_fmt[i].bytesperline *
>> +                                          ef->height / info->vdiv;
>> +             ef->plane_fmt[0].sizeimage -= ef->plane_fmt[i].sizeimage;
>> +     }
>> +}
>> +
>> +static void
>> +v4l2_pix_mp_format_to_ext_pix_format(const struct v4l2_pix_format_mplane *pix_mp,
>> +                                  struct v4l2_ext_pix_format *ef)
>> +{
>> +     const struct v4l2_format_info *info =
>> +                                     v4l2_format_info(pix_mp->pixelformat);
>> +     unsigned int i;
>> +
>> +     ef->width = pix_mp->width;
>> +     ef->height = pix_mp->height;
>> +     ef->field = pix_mp->field;
>> +     ef->colorspace = pix_mp->colorspace;
>> +     ef->ycbcr_enc = pix_mp->ycbcr_enc;
>> +     ef->quantization = pix_mp->quantization;
>> +     ef->xfer_func = pix_mp->xfer_func;
>> +     if (pix_mp->flags)
>> +             pr_warn("Ignoring pixelformat flags 0x%x\n", pix_mp->flags);
>> +
>> +     if (!info)
>> +             return;
> 
> If we return here, the returned ef will not make any sense, because it
> would have uninitialized plane_fmt[]. Should we print a warning here too?
> 
>> +
>> +     ef->pixelformat = pix_mp->pixelformat;
>> +
>> +     if (info->comp_planes == info->mem_planes) {
>> +             for (i = 0; i < pix_mp->num_planes && i < VIDEO_MAX_PLANES; i++)
>> +                     ef->plane_fmt[i] = pix_mp->plane_fmt[i];
>> +
>> +             return;
>> +     }
>> +
>> +     /* case where mem_planes is 1 and comp_planes > 1 */
>> +     ef->plane_fmt[0] = pix_mp->plane_fmt[0];
>> +     for (i = 1; i < info->comp_planes; i++) {
>> +             ef->plane_fmt[i].bytesperline =
>> +                     pix_mp->plane_fmt[0].bytesperline / info->hdiv;
>> +             ef->plane_fmt[i].sizeimage =
>> +                     ef->plane_fmt[i].bytesperline * ef->height / info->vdiv;
>> +             ef->plane_fmt[0].sizeimage -= ef->plane_fmt[i].sizeimage;
>> +     }
>> +}
>> +
>> +/*
>> + * v4l2_format_to_ext_pix_format - convert to v4l2_format to v4l2_ext_pix_format
>> + *
>> + * @f: A pointer to struct v4l2_format to be converted.
>> + * @ef: A pointer to struct struct v4l2_ext_pix_format to be filled.
>> + *
>> + * This method normalize the pixelformat to non-M variant.
>> + */
>> +static void v4l2_format_to_ext_pix_format(const struct v4l2_format *f,
>> +                                       struct v4l2_ext_pix_format *ef)
>> +{
>> +     memset(ef, 0, sizeof(*ef));
>> +
>> +     switch (f->type) {
>> +     case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>> +     case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>> +             ef->type = f->type;
>> +             v4l2_pix_format_to_ext_pix_format(&f->fmt.pix, ef);
>> +             break;
>> +     case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> +             ef->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>> +             v4l2_pix_mp_format_to_ext_pix_format(&f->fmt.pix_mp, ef);
>> +             break;
>> +     case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>> +             ef->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
>> +             v4l2_pix_mp_format_to_ext_pix_format(&f->fmt.pix_mp, ef);
>> +             break;
>> +     default:
>> +             WARN("Converting to Ext Pix Format with wrong buffer type %s\n",
>> +                  prt_names(f->type, v4l2_type_names));
>> +             break;
>> +     }
>> +}
>> +
>>   static int v4l_querycap(const struct v4l2_ioctl_ops *ops,
>>                                struct file *file, void *fh, void *arg)
>>   {
>> @@ -1654,7 +1883,9 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>>                        v4l_pix_format_touch(&p->fmt.pix);
>>                return ret;
>>        case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> -             return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
>> +             if (ops->vidioc_g_fmt_vid_cap_mplane)
>> +                     return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
> 
> What is this change needed for?
> 
>> +             break;
>>        case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>>                return ops->vidioc_g_fmt_vid_overlay(file, fh, arg);
>>        case V4L2_BUF_TYPE_VBI_CAPTURE:
>> @@ -1662,7 +1893,8 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>>        case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
>>                return ops->vidioc_g_fmt_sliced_vbi_cap(file, fh, arg);
>>        case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>> -             if (unlikely(!ops->vidioc_g_fmt_vid_out))
>> +             if (unlikely(!ops->vidioc_g_fmt_vid_out &&
>> +                          !ops->vidioc_g_ext_pix_fmt_vid_out))
> 
> Ditto.
> 
>>                        break;
>>                p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>                ret = ops->vidioc_g_fmt_vid_out(file, fh, arg);
>> @@ -1670,7 +1902,9 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>>                p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>                return ret;
>>        case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>> -             return ops->vidioc_g_fmt_vid_out_mplane(file, fh, arg);
>> +             if (ops->vidioc_g_fmt_vid_out_mplane)
>> +                     return ops->vidioc_g_fmt_vid_out_mplane(file, fh, arg);
>> +             break;
> 
> Ditto.
> 
>>        case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>>                return ops->vidioc_g_fmt_vid_out_overlay(file, fh, arg);
>>        case V4L2_BUF_TYPE_VBI_OUTPUT:
>> @@ -1689,6 +1923,42 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>>        return -EINVAL;
>>   }
>>
>> +static int v4l_g_ext_pix_fmt(const struct v4l2_ioctl_ops *ops,
>> +                          struct file *file, void *fh, void *arg)
>> +{
>> +     struct v4l2_ext_pix_format *ef = arg;
>> +     struct v4l2_format f = {
>> +             .type = ef->type,
>> +     };
>> +     int ret = check_fmt(file, ef->type);
>> +
>> +     if (ret)
>> +             return ret;
>> +
>> +     memset(ef, 0, sizeof(*ef));
>> +     ef->type = f.type;
>> +
>> +     switch (f.type) {
>> +     case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>> +             if (ops->vidioc_g_ext_pix_fmt_vid_cap)
>> +                     return ops->vidioc_g_ext_pix_fmt_vid_cap(file, fh, ef);
>> +             break;
>> +     case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>> +             if (ops->vidioc_g_ext_pix_fmt_vid_out)
>> +                     return ops->vidioc_g_ext_pix_fmt_vid_out(file, fh, ef);
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
> 
> Given that determine_valid_ioctls() will only set the valid ioctl bit if
> the right operation is provided by the driver, when would the code below
> be run?
> 
>> +     ret = v4l_g_fmt(ops, file, fh, &f);
>> +     if (ret)
>> +             return ret;
>> +
>> +     v4l2_format_to_ext_pix_format(&f, ef);
>> +     return 0;
>> +}
>> +
>>   static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>>                                struct file *file, void *fh, void *arg)
>>   {
>> @@ -1794,6 +2064,42 @@ static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>>        return -EINVAL;
>>   }
>>
>> +static int v4l_s_ext_pix_fmt(const struct v4l2_ioctl_ops *ops,()
>> +                          struct file *file, void *fh, void *arg)
>> +{
>> +     struct video_device *vfd = video_devdata(file);
>> +     struct v4l2_ext_pix_format *ef = arg;
>> +     struct v4l2_format f;
>> +     int ret = check_fmt(file, ef->type);
>> +
>> +     if (ret)
>> +             return ret;
>> +
>> +     memset(ef->reserved, 0, sizeof(ef->reserved));
>> +
>> +     switch (ef->type) {
>> +     case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>> +             if (ops->vidioc_s_ext_pix_fmt_vid_cap)
>> +                     return ops->vidioc_s_ext_pix_fmt_vid_cap(file, fh, ef);
>> +             break;
>> +     case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>> +             if (ops->vidioc_s_ext_pix_fmt_vid_out)
>> +                     return ops->vidioc_s_ext_pix_fmt_vid_out(file, fh, ef);
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +
> 
> Ditto.
> 
>> +     v4l2_ext_pix_format_to_format(ef, &f, V4L2_IS_CAP_MULTIPLANAR(vfd));
>> +
>> +     ret = v4l_s_fmt(ops, file, fh, &f);
>> +     if (ret)
>> +             return ret;
>> +
>> +     v4l2_format_to_ext_pix_format(&f, ef);
>> +     return 0;
>> +}
>> +
>>   static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>>                                struct file *file, void *fh, void *arg)
>>   {
>> @@ -1896,6 +2202,44 @@ static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>>        return -EINVAL;
>>   }
>>
>> +static int v4l_try_ext_pix_fmt(const struct v4l2_ioctl_ops *ops,
>> +                            struct file *file, void *fh, void *arg)
>> +{
>> +     struct video_device *vfd = video_devdata(file);
>> +     struct v4l2_ext_pix_format *ef = arg;
>> +     struct v4l2_format f;
>> +     int ret = check_fmt(file, ef->type);
>> +
>> +     if (ret)
>> +             return ret;
>> +
>> +     memset(ef->reserved, 0, sizeof(ef->reserved));
>> +
>> +     switch (ef->type) {
>> +     case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>> +             if (ops->vidioc_try_ext_pix_fmt_vid_cap)
>> +                     return ops->vidioc_try_ext_pix_fmt_vid_cap(file, fh,
>> +                                                                ef);
>> +             break;
>> +     case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>> +             if (ops->vidioc_try_ext_pix_fmt_vid_out)
>> +                     return ops->vidioc_try_ext_pix_fmt_vid_out(file, fh,
>> +                                                                ef);
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
> 
> Ditto.
> 
>> +
>> +     v4l2_ext_pix_format_to_format(ef, &f, V4L2_IS_CAP_MULTIPLANAR(vfd));
>> +
>> +     ret = v4l_try_fmt(ops, file, fh, &f);
>> +     if (ret)
>> +             return ret;
>> +
>> +     v4l2_format_to_ext_pix_format(&f, ef);
>> +     return 0;
>> +}
>> +
>>   static int v4l_streamon(const struct v4l2_ioctl_ops *ops,
>>                                struct file *file, void *fh, void *arg)
>>   {
>> @@ -2902,6 +3246,9 @@ static const struct v4l2_ioctl_info v4l2_ioctls[] = {
>>        IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands, v4l_print_freq_band, 0),
>>        IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info, v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>>        IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl, v4l_print_query_ext_ctrl, INFO_FL_CTRL | INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>> +     IOCTL_INFO(VIDIOC_G_EXT_PIX_FMT, v4l_g_ext_pix_fmt, v4l_print_ext_pix_format, 0),
>> +     IOCTL_INFO(VIDIOC_S_EXT_PIX_FMT, v4l_s_ext_pix_fmt, v4l_print_ext_pix_format, INFO_FL_PRIO),
>> +     IOCTL_INFO(VIDIOC_TRY_EXT_PIX_FMT, v4l_try_ext_pix_fmt, v4l_print_ext_pix_format, 0),
>>   };
>>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>
>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
>> index edb733f21604..c44708dc9355 100644
>> --- a/include/media/v4l2-ioctl.h
>> +++ b/include/media/v4l2-ioctl.h
>> @@ -48,11 +48,17 @@ struct v4l2_fh;
>>    * @vidioc_g_fmt_vid_cap: pointer to the function that implements
>>    *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video capture
>>    *   in single plane mode
>> + * @vidioc_g_ext_pix_fmt_vid_cap: pointer to the function that implements
>> + *   :ref:`VIDIOC_G_EXT_PIX_FMT <vidioc_g_ext_pix_fmt>` ioctl logic for video
>> + *   capture
>>    * @vidioc_g_fmt_vid_overlay: pointer to the function that implements
>>    *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>>    * @vidioc_g_fmt_vid_out: pointer to the function that implements
>>    *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video out
>>    *   in single plane mode
>> + * @vidioc_g_ext_pix_fmt_vid_out: pointer to the function that implements
>> + *   :ref:`VIDIOC_G_EXT_PIX_FMT <vidioc_g_ext_pix_fmt>` ioctl logic for video
>> + *   out
>>    * @vidioc_g_fmt_vid_out_overlay: pointer to the function that implements
>>    *   :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video overlay output
>>    * @vidioc_g_fmt_vbi_cap: pointer to the function that implements
>> @@ -82,11 +88,16 @@ struct v4l2_fh;
>>    * @vidioc_s_fmt_vid_cap: pointer to the function that implements
>>    *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video capture
>>    *   in single plane mode
>> + * @vidioc_s_ext_pix_fmt_vid_cap: pointer to the function that implements
>> + *   :ref:`VIDIOC_S_EXT_PIX_FMT <vidioc_g_ext_pix_fmt>` ioctl logic for video
>> + *   capture
>>    * @vidioc_s_fmt_vid_overlay: pointer to the function that implements
>>    *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>>    * @vidioc_s_fmt_vid_out: pointer to the function that implements
>>    *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video out
>>    *   in single plane mode
>> + * @vidioc_s_ext_pix_fmt_vid_out: pointer to the function that implements
>> + *   :ref:`VIDIOC_S_EXT_PIX_FMT <vidioc_g_fmt>` ioctl logic for video out
>>    * @vidioc_s_fmt_vid_out_overlay: pointer to the function that implements
>>    *   :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video overlay output
>>    * @vidioc_s_fmt_vbi_cap: pointer to the function that implements
>> @@ -116,11 +127,16 @@ struct v4l2_fh;
>>    * @vidioc_try_fmt_vid_cap: pointer to the function that implements
>>    *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video capture
>>    *   in single plane mode
>> + * @vidioc_try_ext_pix_fmt_vid_cap: pointer to the function that implements
>> + *   :ref:`VIDIOC_TRY_EXT_PIX_FMT <vidioc_g_ext_pix_fmt>` ioctl logic for
>> +     video capture
>>    * @vidioc_try_fmt_vid_overlay: pointer to the function that implements
>>    *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>>    * @vidioc_try_fmt_vid_out: pointer to the function that implements
>>    *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video out
>>    *   in single plane mode
>> + * @vidioc_try_ext_pix_fmt_vid_out: pointer to the function that implements
>> + *   :ref:`VIDIOC_TRY_EXT_PIX_FMT <vidioc_g_fmt>` ioctl logic for video out
>>    * @vidioc_try_fmt_vid_out_overlay: pointer to the function that implements
>>    *   :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>>    *   output
>> @@ -319,10 +335,14 @@ struct v4l2_ioctl_ops {
>>        /* VIDIOC_G_FMT handlers */
>>        int (*vidioc_g_fmt_vid_cap)(struct file *file, void *fh,
>>                                    struct v4l2_format *f);
>> +     int (*vidioc_g_ext_pix_fmt_vid_cap)(struct file *file, void *fh,
>> +                                         struct v4l2_ext_pix_format *ef);
>>        int (*vidioc_g_fmt_vid_overlay)(struct file *file, void *fh,
>>                                        struct v4l2_format *f);
>>        int (*vidioc_g_fmt_vid_out)(struct file *file, void *fh,
>>                                    struct v4l2_format *f);
>> +     int (*vidioc_g_ext_pix_fmt_vid_out)(struct file *file, void *fh,
>> +                                         struct v4l2_ext_pix_format *ef);
>>        int (*vidioc_g_fmt_vid_out_overlay)(struct file *file, void *fh,
>>                                            struct v4l2_format *f);
>>        int (*vidioc_g_fmt_vbi_cap)(struct file *file, void *fh,
>> @@ -349,10 +369,14 @@ struct v4l2_ioctl_ops {
>>        /* VIDIOC_S_FMT handlers */
>>        int (*vidioc_s_fmt_vid_cap)(struct file *file, void *fh,
>>                                    struct v4l2_format *f);
>> +     int (*vidioc_s_ext_pix_fmt_vid_cap)(struct file *file, void *fh,
>> +                                         struct v4l2_ext_pix_format *ef);
>>        int (*vidioc_s_fmt_vid_overlay)(struct file *file, void *fh,
>>                                        struct v4l2_format *f);
>>        int (*vidioc_s_fmt_vid_out)(struct file *file, void *fh,
>>                                    struct v4l2_format *f);
>> +     int (*vidioc_s_ext_pix_fmt_vid_out)(struct file *file, void *fh,
>> +                                         struct v4l2_ext_pix_format *ef);
>>        int (*vidioc_s_fmt_vid_out_overlay)(struct file *file, void *fh,
>>                                            struct v4l2_format *f);
>>        int (*vidioc_s_fmt_vbi_cap)(struct file *file, void *fh,
>> @@ -379,10 +403,14 @@ struct v4l2_ioctl_ops {
>>        /* VIDIOC_TRY_FMT handlers */
>>        int (*vidioc_try_fmt_vid_cap)(struct file *file, void *fh,
>>                                      struct v4l2_format *f);
>> +     int (*vidioc_try_ext_pix_fmt_vid_cap)(struct file *file, void *fh,
>> +                                           struct v4l2_ext_pix_format *ef);
>>        int (*vidioc_try_fmt_vid_overlay)(struct file *file, void *fh,
>>                                          struct v4l2_format *f);
>>        int (*vidioc_try_fmt_vid_out)(struct file *file, void *fh,
>>                                      struct v4l2_format *f);
>> +     int (*vidioc_try_ext_pix_fmt_vid_out)(struct file *file, void *fh,
>> +                                           struct v4l2_ext_pix_format *ef);
>>        int (*vidioc_try_fmt_vid_out_overlay)(struct file *file, void *fh,
>>                                             struct v4l2_format *f);
>>        int (*vidioc_try_fmt_vbi_cap)(struct file *file, void *fh,
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 17a9b975177a..74a8dd7f7637 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -840,7 +840,8 @@ struct v4l2_fmtdesc {
>>        __u8                description[32];   /* Description string */
>>        __u32               pixelformat;       /* Format fourcc      */
>>        __u32               mbus_code;          /* Media bus code    */
>> -     __u32               reserved[3];
>> +     __u64               modifier;           /* Format modifier   */
> 
> How would that work? Would the driver expose multiple entries for the
> same pixelformat, just with different modifier?
> 
>> +     __u32               reserved;
>>   };
>>
>>   #define V4L2_FMT_FLAG_COMPRESSED             0x0001
>> @@ -2417,6 +2418,45 @@ struct v4l2_format {
>>        } fmt;
>>   };
>>
>> +/**
>> + * struct v4l2_ext_pix_format - extended multiplanar format definition
>> + * @type:            enum v4l2_buf_type; type of the data stream
>> + * @width:           image width in pixels
>> + * @height:          image height in pixels
>> + * @pixelformat:     little endian four character code (fourcc)
>> + * @modifier:                modifier applied to the format (used for tiled formats
>> + *                   and other kind of HW-specific formats, like compressed
>> + *                   formats) as defined in drm_fourcc.h
>> + * @field:           enum v4l2_field; field order (for interlaced video)
>> + * @colorspace:              enum v4l2_colorspace; supplemental to pixelformat
>> + * @plane_fmt:               per-plane information
>> + * @flags:           format flags (V4L2_PIX_FMT_FLAG_*)
>> + * @ycbcr_enc:               enum v4l2_ycbcr_encoding, Y'CbCr encoding
>> + * @hsv_enc:         enum v4l2_hsv_encoding, HSV encoding
>> + * @quantization:    enum v4l2_quantization, colorspace quantization
>> + * @xfer_func:               enum v4l2_xfer_func, colorspace transfer function
>> + * @reserved:                drivers and applications must zero this array
>> + */
>> +struct v4l2_ext_pix_format {
>> +     __u32                           type;
>> +     __u32                           width;
>> +     __u32                           height;
>> +     __u32                           pixelformat;
>> +     __u64                           modifier;
>> +     __u32                           field;
>> +     __u32                           colorspace;
>> +
>> +     struct v4l2_plane_pix_format    plane_fmt[VIDEO_MAX_PLANES];
>> +     __u8                            flags;
>> +      union {
> 
> nit: Spurious space before "union".
> 
> Best regards,
> Tomasz
> 
>> +             __u8                            ycbcr_enc;
>> +             __u8                            hsv_enc;
>> +     };
>> +     __u8                            quantization;
>> +     __u8                            xfer_func;
>> +     __u32                           reserved[10];
>> +} __attribute__ ((packed));
>> +
>>   /*   Stream type-dependent parameters
>>    */
>>   struct v4l2_streamparm {
>> @@ -2690,6 +2730,10 @@ struct v4l2_create_buffers {
>>
>>   #define VIDIOC_QUERY_EXT_CTRL        _IOWR('V', 103, struct v4l2_query_ext_ctrl)
>>
>> +#define VIDIOC_G_EXT_PIX_FMT _IOWR('V', 104, struct v4l2_ext_pix_format)
>> +#define VIDIOC_S_EXT_PIX_FMT _IOWR('V', 105, struct v4l2_ext_pix_format)
>> +#define VIDIOC_TRY_EXT_PIX_FMT       _IOWR('V', 106, struct v4l2_ext_pix_format)
>> +
>>   /* Reminder: when adding new ioctls please add support for them to
>>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>>
>> --
>> 2.17.1
>>

-- 
Hsia-Jun(Randy) Li
