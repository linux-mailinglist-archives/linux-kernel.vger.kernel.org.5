Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533FF7E0D45
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378229AbjKDCPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378207AbjKDCPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:15:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA8123;
        Fri,  3 Nov 2023 19:15:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-280cd4e6f47so621565a91.1;
        Fri, 03 Nov 2023 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699064136; x=1699668936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76/z41L+zk5wrCtLhnih2S9eliDBN2yItIpsN/eleis=;
        b=ZWksbYPtV11aqLJd2APoCbm/y3eFwPkJjg1WUjVR9l2RTZ6ziax+EVSKVUZ4VA/FFa
         NK/GG9A5fOOO+8jltup6zQvGBe23X5ovdzU8AL5w4vzk3wOb2nB/ROAwFto00jp8RG9p
         ruUQthpkuZYNRoOfeeRWVoeE1fu14XeohJxCFugIZOqRaBmbETRaPpQd4gAktbYdEzq5
         42ocBhVqT3mqolbG5HntM1fI//WMYCawPOOjw4GrYZQbiomXvuhPpwzt+KjyPBdqX6T2
         tIh5XplSAo7DQzilj5x79XtrjWiz9tCrdpcoGoRmXR72ODF45fUeI8AX5ktYpVtwOkPG
         XAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699064136; x=1699668936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76/z41L+zk5wrCtLhnih2S9eliDBN2yItIpsN/eleis=;
        b=aUd8cXVEbCrD3Qr9bHhYfwcLOOErA8fP+E1jC1siloFZceJShPkBJTCfFBLBsHDrpe
         Xir+fNb2yTgZANfJN8h88LQXT0o0oCbpk7qyyRxNCecYEcz3ng42Pif50DBjgSS4zqAj
         FHXt8K/Qo/ke1QvPLdI3EYesrJR9UNkdBK2jBUS0mJD7/inIg6eMQ0qCWsPfhUaoQL6u
         FuEvVG32PTJPZmjr3zCaTjfNwY0HuAj6UdqhYyNAgKdZzaJYPLld9ursLMxJyWKseE+O
         ctS+M3yWuLwcM1d6l6BrXZ7d5xHKiYLxf23cbHkefRPgSWL/VvlFb5gH6xv6/dFcTFye
         1B3w==
X-Gm-Message-State: AOJu0YyTfLjKNLcmIYyOkEiC9WRyLfI3GullTKn3uRDUZ1gOKElp7QTL
        LstdqyVWiPduuY9s3u79zOE=
X-Google-Smtp-Source: AGHT+IF3uXnzHsO9MzLLV26ucGYugrouumxcKHY81yxmi8qZfzqQTEyOrFTXbHbtuWDbRO8HpvI3Sw==
X-Received: by 2002:a17:90a:fe10:b0:280:a26f:5860 with SMTP id ck16-20020a17090afe1000b00280a26f5860mr11160031pjb.1.1699064135885;
        Fri, 03 Nov 2023 19:15:35 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id gt14-20020a17090af2ce00b00280c6f35546sm1893772pjb.49.2023.11.03.19.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 19:15:35 -0700 (PDT)
Date:   Fri, 3 Nov 2023 19:15:32 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Edward Adam Davis <eadavis@qq.com>, habetsm.xilinx@gmail.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <ZUWpRBdv76P_H8aV@hoboy.vegasvil.org>
References: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>
 <ZUPnlsm91R72MBs7@dev>
 <ZUWoyxIgl6vDFsjp@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUWoyxIgl6vDFsjp@hoboy.vegasvil.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 07:13:31PM -0700, Richard Cochran wrote:
> See ptp_clock.c:
> 
>  416         case PTP_CLOCK_EXTTS:
>  417                 /* Enqueue timestamp on selected queues */
>  418                 list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
>  419                         if (test_bit((unsigned int)event->index, tsevq->mask))
>  420                                 enqueue_external_timestamp(tsevq, event);
>  421                 }
>  422                 wake_up_interruptible(&ptp->tsev_wq);
>  423                 break;

And that code can be called from interrupt context.

Thus the mutex won't work.

It needs to be a spin lock instead.

Thanks,
Richard
