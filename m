Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E7756504
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGQNaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjGQNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:30:25 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F310EB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:29:29 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1b0249f1322so3367596fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689600567; x=1692192567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlOZsND84SciXvANY0CY+bWfRMfFwSqDhQDkgMJyHW4=;
        b=su28WUHted4y2Oj1pXVgib331DwEKro8z6itNDd1Gm7nZ7vM4mFGUgtCZ6hjaFA1r/
         rPdTUuAEI+TjHhMPJKU1aBdFopNIKdPu6iynDtH/E5kYJQ+MSHq4qafbcAKzHVreO/wW
         Bh+yaNL9wGR+5ps8uqFyk9qfcKSDCclbqZyILiq04EvOqQcOmNZKV+9SOSmXXIf5GVYe
         ETLudOUUrfVDc2rnQZO0nxKOlKo8sC1b36Q/AVOuJ+ti4WRM1xpkrB7Z5L/N9tassJB8
         uHlOfUWNJI5TLHM3m3orCV59FMoxoYLwuaTZinupE+IufuDDWA9q6GS/WjmC/pil9MvC
         vOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600567; x=1692192567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlOZsND84SciXvANY0CY+bWfRMfFwSqDhQDkgMJyHW4=;
        b=Ve/PQ9wwmD1Iv0Bo4tnOrVdtG5PYGfQZCD2/W1l0I2uu+DF11GZzbmUDTWizPJrzGB
         SicLUr1KQRlDT80m/EadTZRIVDU8ozWAV6hG6ymEbaWYxnXBfMvmryyUWEaaGog/aovp
         Yk0JHB1K3AAnH0h2yE3y0X/d9zC2oZKbR3FOmNtGJns3X3aAuqGVYBSXhotsksQr0lI2
         lTEbLjQzSfnmNlfRlegYGboKJInzkqVDs7axzIEY1d3R85kz5skjlztu8Sooz6/yC8Wi
         1ETv7TOvCTWO/YCj7UJHyKBaqCtowLUQk69SS2z0QAospRWPUPdQgoeQBgRroSgUHMEi
         wXhg==
X-Gm-Message-State: ABy/qLbftuRWutVko1AoozwyKdp05QH03heQhd1QaByEhPxarTfpOXHu
        LL0QmdD+MnMzF8q1HrCylDnGc5tuMmU=
X-Google-Smtp-Source: APBJJlHa1ZtqPyW2vqUQ0hrrWHDJPQkicBRVi7Xdr6CGCwyTOreQeweeePubn5yzkH8ZlyomftM08w==
X-Received: by 2002:a05:6870:1494:b0:1b0:3b98:50e4 with SMTP id k20-20020a056870149400b001b03b9850e4mr13065013oab.58.1689600566997;
        Mon, 17 Jul 2023 06:29:26 -0700 (PDT)
Received: from geday ([2804:7f2:8006:9379:516e:42c5:d582:55d9])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6488000000b006b9cb784553sm2127424otl.36.2023.07.17.06.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:29:26 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:29:22 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Subject: Re: [syzbot] [alsa?] memory leak in snd_seq_create_port
Message-ID: <ZLVCMoC0nLAXCMUS@geday>
References: <00000000000098ed3a0600965f89@google.com>
 <87v8ekattg.wl-tiwai@suse.de>
 <ZLQ/zKgTGMHy/6Jn@geday>
 <87y1jfjbmj.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1jfjbmj.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 08:27:48AM +0200, Takashi Iwai wrote:
> 
> It's a bug that happened only on 6.5-rc1, so no need to bother too
> much with security issue fiasco for distros.

Thanks Takashi. I tried to create a DoS to exhaust all memory through
this bug but ran on other unrelated issues with 6.5-rc1. Glad syzbot
caught this. Thanks!

Geraldo Nascimento

> 
> 
> Takashi
