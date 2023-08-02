Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2496D76C518
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHBGAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjHBGAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:00:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2F8212B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:00:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe11652b64so10720337e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 23:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690956006; x=1691560806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3cBDFlmb0rLF7U5GOTszA6HHKFGynKk1sTqKDLZ/qc=;
        b=GzLGd6zt9F36vIYWCCnW7JC4cohWO1OJumfTx8hZ7k1Js0REj9KbY4Iimnmg1WT8OF
         TLPFyznT9cyeI8fi8odvIwHLQetGrRKNwempF5YxE3YPc7RgezWPE6wagjLjSjqxF669
         6ZjKkCvFNFN6XGG5MDoKz1uqESXiiOfiGbq4sphDa0wwPvXipUSiZuF9SzNUsbMM9xHH
         +skOsZPAmit/E7Iykx3eFUKIO2qgA55dhpFPUCksGZRvRKwTtWLLSReSXZyGWrEzv8wi
         IkHvMLqe9Puo/SdThRI2c17qBPeMePB1tkjuvdCRG+WxO6LZuFUcqP446gLy4L21LHgu
         qJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690956006; x=1691560806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3cBDFlmb0rLF7U5GOTszA6HHKFGynKk1sTqKDLZ/qc=;
        b=KqymGELXgMMkwkulw4sJJ2IyrVnDT4gttJpuBD+PcgHHiQyqntFGdfI1rUeiZTzLGH
         DN9YSoPtAmQBgr+xxWkXs4Trs8nUWpIoTizd/HpgM9aaXJdurhITT2W1NuOt4KJp8zwj
         Gou/2JTvWQp7zpBXBnFvWc4synyG0rTcGMDSwPPRX49uNYP35rfUSY9ZfcRL6Xw6U8Vj
         M0FGiLenT4VqlFsicdBOXgzguJJCKizSfj6EI9EcRbO7MbPIvia6NLzGVfRzwDPTo01y
         jL2v0qUoTIEInL5umfzDHeeXTTl0UDEXO09C/TuNtXNsB7xcz9ZwLdX/B3Hh7NONwoN1
         +Vpg==
X-Gm-Message-State: ABy/qLYgkyqXkkdv/5hWSlRVUpVJ5EQFxku4fWnUK/4wnn5TkXtyxUgK
        hhscawLZjdoYV4l5P2bg7O+juw==
X-Google-Smtp-Source: APBJJlFGk/uFoEFmSJSgr6va1DLUes/+N8hdaYJZu7fVLQH5vlglbTPNtnJ1o23FikkmSh62nEDj9Q==
X-Received: by 2002:a05:6512:3291:b0:4fb:91c5:fd38 with SMTP id p17-20020a056512329100b004fb91c5fd38mr3437958lfe.0.1690956006505;
        Tue, 01 Aug 2023 23:00:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003fe195cecb3sm735815wmk.38.2023.08.01.23.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:00:06 -0700 (PDT)
Date:   Wed, 2 Aug 2023 09:00:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Ruan Jinjie <ruanjinjie@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] net: hisilicon: fix the return value handle and
 remove redundant netdev_err() for platform_get_irq()
Message-ID: <079063f5-e8e1-4a5f-8124-34d79d2fc9bd@kadam.mountain>
References: <20230731073858.3633193-1-ruanjinjie@huawei.com>
 <20230801144347.140cc06f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801144347.140cc06f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:43:47PM -0700, Jakub Kicinski wrote:
> On Mon, 31 Jul 2023 15:38:58 +0800 Ruan Jinjie wrote:
> > There is no possible for platform_get_irq() to return 0
> > and the return value of platform_get_irq() is more sensible
> > to show the error reason.
> > 
> > And there is no need to call the netdev_err() function directly to print
> > a custom message when handling an error from platform_get_irq() function as
> > it is going to display an appropriate error message in case of a failure.
> > 
> > Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> 
> Dan, with the sample of one patch from you I just applied I induce
> that treating 0 as error and returning a -EINVAL in that case may
> be preferable here?

This patch is correct.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

The comments for platform_get_irq() say it returns negatives on error
and that's also how the code is implemented.

Is zero an error code?  Historically, a lot of IRQ functions returned
0 on error and some of those haven't been replaced with new functions
that return negative error codes.  irq_of_parse_and_map() is an example
of this.  I've been meaning to make a complete list but apparently
that's the only one Smatch checks for.

Is zero a valid IRQ?  In upstream code the answer is no and it never
will be.  In this code the platform_get_irq_optional() will trigger a
warning for that.
	if (WARN(!ret, "0 is an invalid IRQ number\n"))
However there are some old out of tree arches where zero is a valid IRQ.

regards,
dan carpenter

