Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB09775103
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjHICpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHICpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:45:31 -0400
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06C198A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=PBMa/HkMbr09EnG8PyKnTCTyIcwYNw/DhfyHL
        i1Twxo=; b=EeJgM7X32kZpwHyBDAr+1Aiz/EP4516QEMBT2HuogDervAVk8upzz
        SO/hw1/CSHWb0+cHJ0L9J+69LGRg5c77C3G/Wy2nPhZWY2QfjFrdCzZv58eQBxkH
        7nH7nojVDifQF4fNEwj5YCJSJphJmM7DtJfyJXJKtti7oZqto0xlSc=
Received: from localhost (unknown [119.3.119.18])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgBnOISz_dJk6icVAA--.15988S3;
        Wed, 09 Aug 2023 10:45:08 +0800 (CST)
Date:   Wed, 9 Aug 2023 10:45:07 +0800
From:   Liang Li <liliang6@email.cn>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH] perf/smmuv3: Add platform id table for module auto
 loading
Message-ID: <ZNL9s92HjLy+MZTw@localhost>
Reply-To: Liang Li <liliang6@email.cn>
References: <20230807122233.28563-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807122233.28563-1-yangyicong@huawei.com>
X-CM-TRANSID: LCKnCgBnOISz_dJk6icVAA--.15988S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZryfXw4kZF1UJryDuF1Dtrb_yoW3Wrg_ur
        WUWF4v9w4UtFyxWay3AFsrArn2yFy2v3yUAwn7tr9xt343Xrn5Jay09ry7Xw1aqa92yrn3
        WF98ZFWvqrW2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbo8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6r1S6rWUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VWx
        Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAKzI0EY4vE52x082
        I5MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07Ua4EiUUUUU=
X-Originating-IP: [119.3.119.18]
X-CM-SenderInfo: 5oloxttqjwqvhpdlzhdfq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-07 20:22, Yicong Yang <yangyicong@huawei.com> wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On ACPI based system the device is probed by the name directly. If the
> driver is configured as module it can only be loaded manually. Add the
> platform id table as well as the module alias then the driver will be
> loaded automatically by the udev or others once the device added.
>

Please consider revise the long log to clearly express the purpose of the
changes in this patch:

- What's the exact issue the patch is addressing
- Why the changes in this patch can fix the issue or make something working
- Consider impact of the changes introduced by this patch

These info may help reviewers and maintainers .. and yourself on code merge.

Regards.

