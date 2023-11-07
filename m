Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2DB7E3516
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjKGGNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGGNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:13:08 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD6410F;
        Mon,  6 Nov 2023 22:13:05 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd20c30831so974946b3a.1;
        Mon, 06 Nov 2023 22:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699337585; x=1699942385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYDdK5bxPox1XDZTxjW6zzD5nW+jVYa/FuFqSU8icUM=;
        b=EX/9QLC4rkeRsgc+c2OqF6gYkQH43wBqJWbx46oKQtTaRsdiNY99+0/In00/AtLbI8
         CoGcFeEc65+ZGD4YL42CFa4G0VH0ZJ3/u/43yePBGhn9/TbCGO3fbcqnpAXxsKp8a2/2
         h1Gs7iqDxg/OZAs6Q2OTGjKeu2gslBsa6IL437LX/aA8asuCqmyuILCqUVQ+B/5XQY6L
         OGPRABhHgc8rTh4/FFfTgDGLbrisSRM8MhZ/LW0ZIbnnVDL9E4o8NsU/cq8hYVLCZ3au
         uCECtUXznuhEp7VyTphJR0cuBZ5zAED8KT7lOHPEHfDMUF1ZYGdMu4FI8I9kKDqCsqRP
         oyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337585; x=1699942385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYDdK5bxPox1XDZTxjW6zzD5nW+jVYa/FuFqSU8icUM=;
        b=VMoWNMPnjKvE0BkB1z11pqBUf/jBPhk28ZPoJfjUO8Y19fudCOj7fZif2+8fsbTDDu
         jdAIWgCzdH5IIztAIefAir7hp12+yGT28E+8Pw5JVCgxRuHylebsAUIT+Y8GnB9ZQZIl
         jGgAjq/EZIFZndJ4oBFBHmjcV6zdaJVbSSrSf3zDUHHEH2UZ5N1zOcLJWwvScp8DajGo
         4EJT+WfOocUeuSoCPIvM8odmmtZllctr4SSx97aAQ1mpt9lm7arEC4wEIhuK0mqaTDAu
         PhX1W60WG2h5sM0TURQukqjXUPsYgo8F5hJahllp8Gj/KtoHBw3BaabIL/8wl8JePXm+
         ozoQ==
X-Gm-Message-State: AOJu0YzmfpSgbjAZtOo2EQ0wqFFKRmoNt4LN9gr/ttwmQ/CuPrStM8xw
        cD0YBhS8KUukopiJsu0J1c0=
X-Google-Smtp-Source: AGHT+IGHq3RsTsOApBXXHfRMGdLm3/XmlgmQt2GrdztgBlzcj6/WtoF+2EeTCPS5SL3OYPSU3f///g==
X-Received: by 2002:a05:6a00:309b:b0:6b9:7d5c:bb58 with SMTP id bh27-20020a056a00309b00b006b97d5cbb58mr29937251pfb.0.1699337584912;
        Mon, 06 Nov 2023 22:13:04 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id bd32-20020a056a0027a000b006870ed427b2sm6626300pfb.94.2023.11.06.22.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 22:13:04 -0800 (PST)
Date:   Mon, 6 Nov 2023 22:13:02 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, habetsm.xilinx@gmail.com, jeremy@jcline.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V8 1/2] ptp: ptp_read should not release queue
Message-ID: <ZUnVbk-1Y-Yxq5ik@hoboy.vegasvil.org>
References: <tencent_AD33049E711B744BDD1B3225A1BA3DBB9A08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AD33049E711B744BDD1B3225A1BA3DBB9A08@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:31:27PM +0800, Edward Adam Davis wrote:
> Firstly, queue is not the memory allocated in ptp_read;
> Secondly, other processes may block at ptp_read and wait for conditions to be
> met to perform read operations.
> 
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

(This should go to net and not net-next.)

Acked-by: Richard Cochran <richardcochran@gmail.com>
