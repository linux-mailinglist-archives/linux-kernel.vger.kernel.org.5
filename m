Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BC7FFCEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjK3Unj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjK3Uni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:43:38 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1ED48
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:43:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc35090b0so13017425ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377024; x=1701981824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BONc/gsZ484W+RnDrWM813jLHbQPmNxKnBVSe2Sio/M=;
        b=W2TrdZpZuktlYQSHQXZ/bmBgwXJBThNuJS6+WYjD+vetDG9z4hRssMaB24MbXhLXn4
         1zeG6jRfQE5LN75o+1f+fx+FIZTgx9ZM2/qf67+Zaao8ZV49ljCFzRt4PQjxxzXEqv2g
         1cg5g/VtYmPBlcr3cFllf2nBu0E8UXFQnyBj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377024; x=1701981824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BONc/gsZ484W+RnDrWM813jLHbQPmNxKnBVSe2Sio/M=;
        b=jln+51i4cz2l2pPTgeAvLNO9lunygMsVMu0rQCv/iyOZiBMCOQTds1MfU/WYckq9x2
         9K91yT1iwWdiFX4n5A8RUc+SAz20gfQlXdYo6QnXWOGQeIqx5cqMaksv8IUJda+hovSQ
         52P6ocAUXfWCYeOSe/1DkfwCLSv9VtfPvGyegGE+U48Bh+nXPXjhoTOMjRuFOJBkpatr
         ruIokeuWHK9ejBQ+LXm9uY68ij7Qffeqxrvu0R7ivQiqiEtthumVz1puFceOt11gH6Vv
         VoWjGEv0e+JN2GmbxD+MiBkv6XFDGnSSxyPpWeKbo/d1Mpn8vHm2CGj0LfQWz3Vefde1
         95Yg==
X-Gm-Message-State: AOJu0YxkVVyfWAt5LlCFoMVu58EU/HwpOoOGi3YHNHAbb/PW3wfsOPrf
        PAwid1D4cDPLRFMn0Njbv3Lb9g==
X-Google-Smtp-Source: AGHT+IHfA9hvAZq8YS/f582nNVUYbicmMy65rHGUVvYZ5n1msLrmQAe6nxVBosEvd4AG2O0JZhCilQ==
X-Received: by 2002:a17:902:d2c2:b0:1d0:4510:133b with SMTP id n2-20020a170902d2c200b001d04510133bmr1831307plc.22.1701377024347;
        Thu, 30 Nov 2023 12:43:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j20-20020a170902759400b001c74df14e6fsm1812526pll.284.2023.11.30.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:43:44 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] samples: Replace strlcpy() with strscpy()
Date:   Thu, 30 Nov 2023 12:43:41 -0800
Message-Id: <170137701899.3640290.1090297958877884765.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116191510.work.550-kees@kernel.org>
References: <20231116191510.work.550-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 11:15:10 -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] samples: Replace strlcpy() with strscpy()
      https://git.kernel.org/kees/c/40b2519d7566

Take care,

-- 
Kees Cook

