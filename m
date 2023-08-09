Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E94776535
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjHIQib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHIQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:38:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE151986
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:38:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d58b3efbso67098f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691599108; x=1692203908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8nX0pI7rFcPckDGFTH0fbolEOZLnYl6aVYECM4juis=;
        b=FxqHIVo7uVYddWJpN82jeeBQLa2SewY2J5gQJly6P2rQgUBkAGNnZ+bgQtmpNDgw4v
         4mN7u5x/LaW6AoYJ+9d0e4LSthWqV17J1YvpHBXPsZZKsDsmd2Zh9HRdhzBRkiL9tE6E
         5f30eiRt4G59OUhlJM1AhxuL3tX7GgVE2HJMYGN3npJ2PmWIiOwxiHgRcuFTRmSEzuE/
         KCg6LJi+hxRAzI9fD9V9XoIViD32ndaMe5/QjonBZNhTcPMPvIb2GQvxmAePgKIZBHbN
         tEIQuTRbltrMWPYaBeS4LecHgQJ6idS15vgVFzZcSokRMVg36JuO5A/AtTawG83t5vMk
         eNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599108; x=1692203908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8nX0pI7rFcPckDGFTH0fbolEOZLnYl6aVYECM4juis=;
        b=C/GtRRjPKSUebdkmjU9GXF3lanNuDQuvc1W5JBQWGtdZgvyF8kPCuk8170CD2JIHlq
         3XLXG+OzVlxJgDkJNTGn95C316uv+T61eFtePFVc0Uma3N64YMH74Q+VBopsb6FFA0EA
         VHlrtAXVwceEz36JRFZtGiTzumkvq6aiOIThGpw267SbRs1IbuGGi/MIAElWBbMOoo4L
         uCVtJwSbuINWbqiQfEYTDxIoxCjiEH6Zr7+XCu6HaqeJuh2dHP0nH33dacGZRK8brWU/
         SgTITzW/HE/fWDTr9On4seYfcYinx+6pa5DuDXKQBNXRylkbeSGslAAz8s7k4rmRuo0m
         RcIQ==
X-Gm-Message-State: AOJu0YzKC4dlzzVXrU4F0KbD7ddyOcs890kBJSeh6+2PU+RSiUxpDxy3
        4Nm/2GApvCGEnYQJ3Ax4QqAfYA==
X-Google-Smtp-Source: AGHT+IEXw5QpPfHSLyKGkNqtuPh+9Tq+iYFSsWhkI2sxKn6VlTHqXOSJRg51iI6lS3t0Y0bELSUsAA==
X-Received: by 2002:adf:d0c2:0:b0:313:f98a:1fd3 with SMTP id z2-20020adfd0c2000000b00313f98a1fd3mr2533598wrh.27.1691599107792;
        Wed, 09 Aug 2023 09:38:27 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d4a09000000b0031801aa34e2sm3250114wrq.9.2023.08.09.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:38:27 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:38:25 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] backlight: lp855x: Drop ret variable in brightness
 change function
Message-ID: <20230809163825.GA5056@aspen.lan>
References: <20230809114216.4078-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809114216.4078-1-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 01:42:16PM +0200, Artur Weber wrote:
> Fixes the following warning:
>
> drivers/video/backlight/lp855x_bl.c:252:7: warning: variable 'ret' is used
> uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> Fixes: 5145531be5fb ("backlight: lp855x: Catch errors when changing brightness")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308091728.NEJhgUPP-lkp@intel.com/

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
