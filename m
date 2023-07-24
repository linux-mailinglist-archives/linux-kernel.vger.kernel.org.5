Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4F75EAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGXFmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGXFmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:42:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5009A6;
        Sun, 23 Jul 2023 22:42:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668704a5b5bso3776105b3a.0;
        Sun, 23 Jul 2023 22:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690177373; x=1690782173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZj5kpfCqCvgRbtU/joxmlUZ8ZQl3bGFXLiviCrla3k=;
        b=N1bjlygBrCSg+LblTPS2D/zuNnpbQnOCeKHwZcAffUASCS8GTY8qgaY1eJ0I25xP04
         ZYq2cTG/JGM8SUvzbv1/ZnrPwxKcjkqMJ8Ftb/B73jzzgidFWvtoojrLaIVmNZgndkRj
         6DhiiA3HaqqgGoV1D7rGWmBoGMJqVx7DdBPpprXFgqvpXQ03grgmfsoI7uNcuRtLIDMF
         2r/IFqqG/Ae49upJusTreIApwBP92oCrPxBS4qe1nxrtWrH03RabbO8YIHT8nUutxF3X
         D8mS/GfbYUJAS5Sl8GqHpL8yVHXy5jkwfLjjt5uIWgRrZ4Ih0Jtc+2fAwE64aL37gFLa
         FhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690177373; x=1690782173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZj5kpfCqCvgRbtU/joxmlUZ8ZQl3bGFXLiviCrla3k=;
        b=d/5U8SjAxiaUGh2mc3WjhnR0HGusIwpm8mTsM3w5cltJq8FjDlowYdDZB/fbPgaFVR
         b5ycHP3PB0sUcJT7Xyi6dc9Luw70WnqV5ls/8vaIagLrrwM+vhOtz0jI9jVtc1boOGom
         51wCjVdOZRsHHyDOdLcG2T5oaV2N1gBo7ZccEkUC6y4+czVqKmQ5gXxGbccdmBUhQSJx
         ljsTcJpON0T2ZxZfTVG/PebX0ehZnYspgxnFrDTVYmtAkeOrs+wWb4Mx5Af98rJp/Gb6
         TUBSxnj2fo7aC7aUvtTR1NKQqByqluTDTGOOghjm9h2fISJmS+YQQsFKyNgspY+LJdjN
         aUkg==
X-Gm-Message-State: ABy/qLY5VOWnkWNaKvSaDCaYf2hmxd9W6jcN2v5xm+TVgLFGL+o4YHYk
        4ltCJsSHo3JncZ7Ip8soS4ZLAu521dw=
X-Google-Smtp-Source: APBJJlGadXYHwu9Uh6SDO9qj+xs1UOfitHGrOiPBXh0GcDSb4Qtb7LXnagxreT3pw4+9u3NebRza1A==
X-Received: by 2002:a05:6a00:1ac8:b0:686:5a11:a434 with SMTP id f8-20020a056a001ac800b006865a11a434mr9469331pfv.3.1690177373184;
        Sun, 23 Jul 2023 22:42:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b0067a50223e3bsm6821384pfh.111.2023.07.23.22.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:42:52 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:42:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: 6.5-rc2: keys autorepeating when they should not
Message-ID: <ZL4PWiinZbeOcvFE@google.com>
References: <ZL0b/odKy/GlEzJV@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL0b/odKy/GlEzJV@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Sun, Jul 23, 2023 at 02:24:30PM +0200, Pavel Machek wrote:
> Hi!
> 
> I updated to 6.5-rc2, and now I see keyboard problems (in X). ~ once
> in two days I get keyboard "stuck", autorepeating. It is USB keyboard,
> hitting another key cancels the autorepeat.

Sounds like keys are not released because autorepeat handled by X and
not the kernel. I am not sure what would cause this, there were no
changes to the input core recently... Maybe HID?

From which kernel did you update to 6.5-rc2? Any chance you could try
bisecting?

Thanks.


-- 
Dmitry
