Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1AF775E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHIMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjHIMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:12:19 -0400
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A0A1982
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=YvdOL9C/iedM5DBNdd9VTjEevDzi7adrzeNuX
        +/2TmA=; b=b7dINqkxcXM7J04e2Wedlkv4IDUK/dRcit0PJ+bQoA+RE6SncbErN
        IPeNV5l8C0myTE0/U1HQxR14AH73x19jdYRzQTZqrSWGYOXjNSEQ38UlLlgLjw6/
        9TcuwI9EI2dh6o/K6tIIUMaZtfhka/mNPZiBFIAK3RHjPpLib9C+xE=
Received: from localhost (unknown [119.3.119.18])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgDnC4KBgtNkuPUVAA--.50580S3;
        Wed, 09 Aug 2023 20:11:46 +0800 (CST)
Date:   Wed, 9 Aug 2023 20:11:45 +0800
From:   Liang Li <liliang6@email.cn>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Barry Song <21cnbao@gmail.com>, Liang Li <liliang6@email.cn>,
        yangyicong@hisilicon.com, will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] perf/smmuv3: Add platform id table for module auto
 loading
Message-ID: <ZNOCgX8yniu+IuUG@localhost>
Reply-To: Liang Li <liliang6@email.cn>
References: <20230807122233.28563-1-yangyicong@huawei.com>
 <ZNL9s92HjLy+MZTw@localhost>
 <CAGsJ_4z5kYWOa2L+BHypM4S6W_UhUfUe3wo2rwiy0u7Hf1Q5pw@mail.gmail.com>
 <23fe3d9a-cb4d-3479-0581-eefec193bc72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23fe3d9a-cb4d-3479-0581-eefec193bc72@huawei.com>
X-CM-TRANSID: LCKnCgDnC4KBgtNkuPUVAA--.50580S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWUZF43XrW8CF43ZrWDurg_yoW8tw43pa
        y8GFy3K3yDJw1rCr92vw47XF1jkws7JFZ5XFn8Jr12v3s09Fy2vry3KayYk34Duwn5C3Wj
        vrWYqa4fG34FyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl
        84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
        8vn2kIc2xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l42xK82IY6x8E
        rcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjrJ5rUUUUU=
X-Originating-IP: [119.3.119.18]
X-CM-SenderInfo: 5oloxttqjwqvhpdlzhdfq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

Thanks for your reply,

On 2023-08-09 14:31, Yicong Yang <yangyicong@huawei.com> wrote:
> Hi Barry, Liang,
> 
> On 2023/8/9 13:47, Barry Song wrote:
> > On Wed, Aug 9, 2023 at 1:01 PM Liang Li <liliang6@email.cn> wrote:
> >>
> >> On 2023-08-07 20:22, Yicong Yang <yangyicong@huawei.com> wrote:
> >>> From: Yicong Yang <yangyicong@hisilicon.com>
> >>>
> >>> On ACPI based system the device is probed by the name directly. If the
> >>> driver is configured as module it can only be loaded manually. Add the
> >>> platform id table as well as the module alias then the driver will be
> >>> loaded automatically by the udev or others once the device added.
> >>>
> >>
> >> Please consider revise the long log to clearly express the purpose of the
> >> changes in this patch:
> >>
> >> - What's the exact issue the patch is addressing
> >> - Why the changes in this patch can fix the issue or make something working
> >> - Consider impact of the changes introduced by this patch
> >>
> >> These info may help reviewers and maintainers .. and yourself on code merge.
> > 
> > years ago, i found a good doc regarding this,
> > https://wiki.archlinux.org/title/Modalias
> > 
> > guess it is because /lib/modules/$(uname -r)/modules.alias fails to contain smmu
> > driver without the MODULE_DEVICE_TABLE, isn't it, yicong？
> 
> Yes I think it's the reason. I didn't find summary in kernel docs for the modalias
> as well as the uevent mechanism. Arch wiki has a well illustration for the modalias
> and suse[1] describes how this is used by the udev for module auto loading.
> 
> For my case I'm using a ACPI based arm64 server and after booting the arm_smmuv3_pmu.ko
> is not auto loaded by the udevd since we aren't providing this information. In order
> to support this we need to provide this MODULE_DEVICE_TABLE() when the smmu pmu added
> as a platform device, then the userspace udev can know which module to load after the
> device is added.
>

Then what's the purpose of the added '.id_table = ...' line in the previous
patch ?
<We lost the patch context in this thread.>

Based on above clarification, the updated DEVICE_TABLE would update modalias
as expected, right ?

> [1] https://documentation.suse.com/sles/15-SP1/html/SLES-all/cha-udev.html#sec-udev-drivers
> 
> Thanks.

Regards.
Liang Li

