Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A17F1346
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjKTM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjKTM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:29:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C010D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:29:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso15632905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700483383; x=1701088183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLBnztJzQ5ZjTU+rkeAICOeEEaHMlSGy5VYix9QDGHU=;
        b=yWQjUq4+EB0cQjc3/vzDuASAjE28r76Cte0ptVH3PO2jSzlg46qMk1D8MwpOeG5l5r
         6U3ZUcWIHML4om8vP/VNtlzYak080dBbOg0MMzsqtmnipbj5eZILBfCpslU63Lf5bNTq
         9s2FHpgWdV51TJGC/2lvOwozh5cvXNjeejqGI/6QnsIsiYj92NV8OzA23TtwS+HDPQt8
         fgxJEl+y7jB3TKimyWZIH3XN1L8qMN5eep6yS8oyxBC+S84Sq9k2EXpzGUZaUjdB9/yk
         0bu2D9M3C+ZPP7aL5s0jhjqZYn8HdOO46mzu6DyR+uJxyb5Rw8ntzTGD9xGYvvpbFQvn
         uSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483383; x=1701088183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLBnztJzQ5ZjTU+rkeAICOeEEaHMlSGy5VYix9QDGHU=;
        b=piTjC697ybcgXhJUPJuSgvCv/OBcw9IQJ/Rd23BS31Ycir1/2ZyH+mQQRWQHaVuI3C
         Dcv8tUVQX+xM53Ahp8jit5AjAe7q2Xq9i+/kIHk31WPhlq0nhSPmXXRBscEwChhaZyG8
         M5o4gUSeTnAkbJdrStCexkcEEPfIibuBPogiuZIPIu/5Ag0Z6ncQUMDJBzkNi/2ERp/k
         eFlrHmcRzPGPUBON5QhIV35fYdVNEuBU3Ff72aiZ+EBEtVUfsQKM/qWylU5hDmlqoz+Z
         woG+vQ7rAUWOWYNyNcj7ms5Rnd+BtdPBLx2nQDdsTNqf1VbmsTwAFML7IqFt2kjDts9W
         944A==
X-Gm-Message-State: AOJu0Yzh7aoJNct5Cws6gP0UvIi5flho0jqXtp7wioqgTUz+WSjVsTA4
        AzZOM/pLQWyy2O/VDnqK/4TNvw==
X-Google-Smtp-Source: AGHT+IGcH5ws8R7gho0xFj6diMMOkXuGzWwmhw29g4OVRwtAvArZiklr60laZWr/59U2F1dra8ebTw==
X-Received: by 2002:a5d:64a5:0:b0:324:84cd:5e67 with SMTP id m5-20020a5d64a5000000b0032484cd5e67mr5631206wrp.6.1700483383381;
        Mon, 20 Nov 2023 04:29:43 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id s6-20020adfdb06000000b0032da49e18fasm11101989wri.23.2023.11.20.04.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:29:42 -0800 (PST)
Date:   Mon, 20 Nov 2023 13:29:41 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        david@ixit.cz
Subject: Re: [PATCH v6 0/2] usb: serial: add support for CH348
Message-ID: <ZVtRNZmCMImCT9sN@Red>
References: <20230628133834.1527941-1-clabbe@baylibre.com>
 <2595072.9XhBIDAVAK@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2595072.9XhBIDAVAK@archbook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Aug 30, 2023 at 07:43:03PM +0200, Nicolas Frattaroli a écrit :
> On Mittwoch, 28. Juni 2023 15:38:32 CEST Corentin Labbe wrote:
> > Hello
> > 
> > The CH348 is an octo serial to USB adapter.
> > The following patch adds a driver for supporting it.
> > Since there is no public datasheet, unfortunatly it remains some magic values.
> > 
> > It was tested with a large range of baud from 1200 to 1500000 and used with
> > success in one of our kernel CI testlab.
> > 
> > Regards
> > 
> > [...]
> 
> Hello,
> 
> thank you for your work on this. I recently made myself a CH348
> board and used this patchset with a small test application[1]
> to see how it performs. Specifically, I ran this on an RK3566
> single board computer, connecting one serial adapter to the
> other, with the test as follows:
> 
>  ./serialtest /dev/ttyUSB0 9600 # UART0 of 1st CH348 board
>  ./serialtest /dev/ttyUSB8 9600 # UART0 of 2nd CH348 board
> 
> One problem I've noticed is that writes to the tty fd never
> seem to block. On two CH340 adapters I have, they do seem to
> block, whereas here, you can see from the statistics at the
> end that magnitudes more bytes were written than read, with
> seemingly most of them being discarded. From my reading of
> the termios parameters I set, this shouldn't be the case,
> right?
> 
> You can see from the error percentage that it gets less
> bad as you increase the serial baudrate; I've tested up
> to 6 mbaud like this. I assume that's because less written
> bytes get discarded.
> 
> Any ideas on whether I'm relying on weird driver behaviour
> with the blocking here or if this driver actually has a
> defect whereby it never signals to userspace that less
> bytes were written than have been submitted?
> 
> Kind regards,
> Nicolas Frattaroli
> 
> [1]: https://github.com/CounterPillow/serialtest
> 

Hello

Sorry for the very long delay of the answer.
I have reproduced the problem on my board.
My reproducer is https://github.com/montjoie/lava-tests/blob/master/test2a2.py

This problem seems to be here since the v1 of my patchset.
The vendor driver seems to work so it is not an hardware problem.

I have no clue at the moment, it is hard to diff with vendor driver since it create tty directly and do not use usbserial.

Regards
