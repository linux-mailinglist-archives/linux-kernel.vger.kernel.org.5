Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6885B77AEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 01:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHMXEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjHMXDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 19:03:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E6BE6F;
        Sun, 13 Aug 2023 16:03:43 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1c504386374so86653fac.3;
        Sun, 13 Aug 2023 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691967822; x=1692572622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKk/GSWLXuV75EYFR2uv8P2JeMyRheqBRft3h3jMq7M=;
        b=EALC5hujBKlJQy6hNibYd+qMXfF/mMM+3zk3Vj+EI3XTmFFjxlKAaYLnE3FTHzfR3C
         bPkKuORehSVzrhP2XIcbSqsdn4CKlwc3L+JdrD2rtM96hihyqLu/+Ko+29RrVdqSK6zM
         lTGFpEgX/UyW/QYMlR4fyoVGc4ZeLjxHwLe/iqI3aJuduUQFA/D8FZHgz4g+SSkM7eqa
         D2NVwNTUnTN7veMquBTABPlFqCw7xOdr3tNuOB4NPDK8K71xdwmFELLl7ycIOjCoyfRl
         Ci6KC7Xf15uy7icV/NhPDPf9agYXlaTYXNqz4ZZMuTNheY6si0Xc89HxepAE+zHt8m5u
         5YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691967822; x=1692572622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKk/GSWLXuV75EYFR2uv8P2JeMyRheqBRft3h3jMq7M=;
        b=Gou2thtO3n2t0D9PXW2MXvO8seYhIOECrQoKBp0LvH4Ji/QyHVhaBTk9fkMNL+R2MI
         0+XBOueE3P67MWkuJhJrrnyT7qBQrm4koMqcfrMbJ/VLKx+epqcq2bCs48LzZxiAgMUq
         xTUq+QXTZIORElj3sV+umkGkwm4ugY5ttWx2xmK1f529Td/ZVEiZJqJ+iB71T6gChRWO
         PRwd8/eUtSIytNIYi4OLy4zRvjk1oByFJ6d9UErDlbWHQ2XofevwVw65RKjC+G1Qe5jI
         SoKgOW2OYtFuvKbQsJQwm2oXCYif2BFv6J+smTojSkNIrFhgIPijlTMjuERNz8nGvCB+
         mw8g==
X-Gm-Message-State: AOJu0YyDQYBwxk0rgN7AH8P8JDZIlUjlfdme25WOvd7x2Sa2+geOxh6y
        7DGfUK4WIJo6Db+HXl0BCr2aokmqn4U=
X-Google-Smtp-Source: AGHT+IGjGxd/9zpmP4udh13qbKifvyV3YGsHQjMDOADL++orgtnaG6R0V4rhQWAx6t+XTHGO30bPvQ==
X-Received: by 2002:a05:6870:9629:b0:1b4:685d:55e4 with SMTP id d41-20020a056870962900b001b4685d55e4mr7361182oaq.39.1691967822412;
        Sun, 13 Aug 2023 16:03:42 -0700 (PDT)
Received: from localhost ([2600:1700:38c1:1d7f:f66d:4ff:fe3c:3ceb])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a5300b0026851759e9csm7304526pjl.29.2023.08.13.16.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 16:03:41 -0700 (PDT)
Date:   Sun, 13 Aug 2023 16:03:37 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srichara@quicinc.com, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [RESEND,PATCH 2/2] firmware: qcom: scm: disable SDI on IPQ5018
Message-ID: <ZNlhSdh0qDMieTAS@localhost>
References: <20230518140224.2248782-1-robimarko@gmail.com>
 <20230518140224.2248782-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518140224.2248782-2-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 04:02:24PM +0200, Robert Marko wrote:
> IPQ5018 seems to have SDI (Secure Debug Image) enabled by default which
> prevents normal reboot from working causing the board to just hang after
> reboot is called.
> 
> So, let disable SDI during SCM probe for IPQ5018.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/firmware/qcom_scm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index bdc9324d4e62..c6a38ce49fb0 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1525,6 +1525,14 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (download_mode)
>  		qcom_scm_set_download_mode(true);
>  
> +	/* IPQ5018 seems to have SDI (Secure Debug Image) enabled by default
> +	 * which will prevent normal reboot causing the board to hang after
> +	 * making the reboot call.
> +	 * So, make a call to SCM to disable SDI.
> +	 */
> +	if (of_machine_is_compatible("qcom,ipq5018"))
> +		qcom_scm_disable_sdi();
> +

I see there has been some reservation expressed on this patch (via patch
1 comments). I suppose this would be a nice time (though months-late) to
add my own potentially-constructive thoughts.

First, this is definitely a real problem, and for multiple products. See
my prior art with the exact same problem:

Subject: [RFC PATCH] firmware: qcom_scm: disable SDI at boot
https://lore.kernel.org/all/20200721080054.2803881-1-computersforpeace@gmail.com/

(I think you found this one already, although independently.)

Secondly, I think some reservation from patch 1 is on the precise method
of identifying such problematic systems, and I think I agree with the
sentiment. For one, I'm sure that in my case, not all IPQ4019-based
systems leave SDI enabled, and similarly, I doubt all IPQ5018 systems do
either. I believe any firmware that has this enabled in a production
system is essentially an oversight and a bug; it provides negative value
to non-Qualcomm-employees (who can't inspect this "debug" mode), and I
also believe it can potentially be "fixed" by firmware updates. So you
have cases where depending on which software updates have been applied
to an original product before being reprogrammed with a properly-open
Linux kernel/distro, the "same" product may or may not behave
differently.

On the other hand, my guess is that it is truly safe (or, redundant) to
make this call on *any* SCM system; if it was already disabled, then
it's a no-op. Now, that may be inconvenient for Qualcomm employees
trying to debug prototype boards, but that's a different problem...

So, it feels like either this should be:
(1) done inconditionally (like my RFC above), or
(2) supported by some kind of dedicated firmware or device tree flag, to
    denote precisely which systems need this behavior, and not just
    guess based on SoCs. We don't have any firmware interface for this
    [1], so I think the next best thing is Device Tree, which I believe
    is sometimes(?) allowed to carry "firmware" information, instead of
    just "hardware" information.

For example, maybe we document a "qcom,firmware-sdi-enabled" boolean, to
represent the fact that the particular board in question may hold
firmware which leaves SDI enabled?

I'd personally also be OK with (1), unless we (or more likely, Qualcomm)
can find some reason that it's not safe/redundant to do this
unconditionally.

Regards,
Brian

[1] As far as I know. There's no documentation about Qualcomm's SCM APIs
    that I'm aware of.
