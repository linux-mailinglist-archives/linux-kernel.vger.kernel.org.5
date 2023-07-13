Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047C7752799
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGMPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjGMPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:44:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33E726AE;
        Thu, 13 Jul 2023 08:44:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31441bc0092so1005082f8f.1;
        Thu, 13 Jul 2023 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689263046; x=1691855046;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FvRlZtB80kqt918KBfquPupEbUMqX2LlONs8BTPE/UM=;
        b=rDx/v+KKofJk5t59ihQAwCJefTYDfG2J/RcIkMvxkYlKfnn83EAoa6LhqYm0m6oag5
         HexVnTsaw21LlqPE46qhz5RQDoAwsAkL9T4GE7eLj2KA3ZzaCG9PZp53dhnXKk3WbeFH
         LbPQmm+8arsg8t6btiQQZSFRA/18UcFiG/wsk2zPwgMzKGALlb063IrCr/mJ3QZnkDoQ
         0y9wNefGRAczsUah46B1kVwfKdO0q3/Fo7+qUxVYiVFcvo4AKCHjZbBpu/njKYvTGGZJ
         6zt/cOyXm/I0G6ffIbwvgjzExX52+iB5Sk2TeLovvJRVIwCtoJdliUZAUDgtKyBwccgu
         SyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689263046; x=1691855046;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvRlZtB80kqt918KBfquPupEbUMqX2LlONs8BTPE/UM=;
        b=hBPGKymeud3X/fh2tqlWIpcdlNdF2yEjvprscp1H1lU9a/qINzS1v5BzC6gKWsnHQA
         ek9mSJOAgrrcED1MMYYrfLWYizZ6lWwhctXZlo5/Vt1X8IrkbefjahZpqpvAgz3yULxd
         Gec2fxGCodjybdtq95Sy9dBorUmXUacYSP1ra6Q54oSFyvDM5Zdi1Wd57DCbqpLEe+AD
         vars2IIa1Uy2mW4eGmQRlRx4/SHM9ti1RmcsKt1jZTiaBxwCHgpuXAVBu/lmEe2AqrLy
         vblxws25uwItI0CVZbMtgKbRST6A2BXi7j2SjSN1HDgfrdgUhLQdq9A9K1H2f5uuOFQv
         RT8A==
X-Gm-Message-State: ABy/qLZYN/qbIqOyCM2ljdyUNUMPWfEEJtJvnYaDkWpMHzw1DIfI+tvf
        Du1P42liJrybIwRKsNXXC6koWnP2SH8rRDq7XSC68YRE
X-Google-Smtp-Source: APBJJlE7ypJFkJKMiobf+oJd6KFK/0cZ2WDyV0/1sSfNX6l4g2ix1HVoQhVhwPcOUaRtZFkUxGAfsUmFrPg+qcjmHzM=
X-Received: by 2002:a5d:42cb:0:b0:311:142d:5d97 with SMTP id
 t11-20020a5d42cb000000b00311142d5d97mr1760374wrr.31.1689263045526; Thu, 13
 Jul 2023 08:44:05 -0700 (PDT)
MIME-Version: 1.0
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Thu, 13 Jul 2023 23:43:54 +0800
Message-ID: <CAJNi4rMK6hc6vh8hwU_zb_p2uQn=FLOmAuAJuF1DxMfyG8nixg@mail.gmail.com>
Subject: Question about the 'bw' field in the fio output
To:     fio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that sometimes the fio command will have an additional 'bw'
field as below:
...
clat percentiles (usec):
  |  1.00th=[.  51]...
bw (  KiB/s): min=45689, max=49753, per=100.00%, avg=49658.56,
stdev=89.23, samples =5
iops            : min=.....
...

Please there is a line beginning with 'bw (  KiB/s)...', but sometimes
the 'bw' line doesn't show, does anybody know the reasons?

Thanks.
