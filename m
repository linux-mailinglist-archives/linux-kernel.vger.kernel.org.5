Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9B47BCFB4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344495AbjJHTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 15:02:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3607AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 12:02:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6934202b8bdso3166642b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696791726; x=1697396526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w1+Qsyy+bFdp5dmNBCr+fP+a+JH1BEYENvEHb1RnYwk=;
        b=CPzLxXVysjPt9BF396+BVj6/Wm5kqek/fBg5CwAqQULe0FHrh8JyC+mxizt+VzQHaQ
         +yjqNpYyIYNlbpexEPaD5cqfS0xYVL3zEuL+Ws2+HYfdUP3Kx85fC6RT8y9jNIlC1oQ2
         0HBKWex3Mps/4LU2SlLtB4UHMJvsgF0twMURoKMRLjTJ/su6S8Uzfakc6bvADvVwFHln
         tlPNMSLpkSsLGkq7LSL81qE5Wd2h15tWic+KF78WZAYOy5/Ac6/c7YJDQYjZugobLUmK
         1YPHYkMQoxY9/9yi8kKQpxBRJXYRKTY5Deyr5cO+JjDqMGQm7FX11kBVndOKCAQl/apZ
         nsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696791726; x=1697396526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1+Qsyy+bFdp5dmNBCr+fP+a+JH1BEYENvEHb1RnYwk=;
        b=ZVxNKUJztox6XAGDh5qw0Stt95ntrlsgoo9G6NjDndm5ZLNGHRk+Ec0XpudBrN0ipo
         VPynSBfyivbtlPeRWi2BLwrP3n79UHgRUpRWkEjezA+TvEUpz2mATCMD9JVMIIQpo0Qo
         rq9OnzRrWwroEZx8KKl59mGZIgTO2JpAT1GgExH3rsu3rL2bBkag06QJoJ+HPnIgVGFj
         BK5SC3xItFQvYqCkBeToiRsZjWzP86tBw4cpxT00mAu2X+EgM6oMjZd4lmEojRPjx9iX
         d1PkAtCeerTJAueLVF/morlgM3hJOAtDxgAQHXTY4FYHSdNmyefZr1zP4ehDodFRehn+
         +sOQ==
X-Gm-Message-State: AOJu0Yyef6ETEyTJ2oPAw9p61ooxzvIc21BDabqMVUSBbV/LCHWo3e22
        yTJVYV+hr3T96GFaG8bpDD65nyorQVI=
X-Google-Smtp-Source: AGHT+IEPuPtqQ5zNPmhUWxQ27zPqwWH7rYWq0GjGIWqAwGdboE2LIkOqDipI4eMn/0YhBFMdQJRmDQ==
X-Received: by 2002:a05:6a00:391d:b0:68e:4303:edb8 with SMTP id fh29-20020a056a00391d00b0068e4303edb8mr15323342pfb.30.1696791726338;
        Sun, 08 Oct 2023 12:02:06 -0700 (PDT)
Received: from ubuntu.. ([223.178.246.252])
        by smtp.gmail.com with ESMTPSA id g12-20020a63be4c000000b00577e62e13c5sm6018165pgo.32.2023.10.08.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 12:02:05 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH v5 0/3] Type encoding info dropped from arrary name "abyBBVGA" and variable names "byBBVGACurrent", "byBBVGANew"
Date:   Mon,  9 Oct 2023 00:31:47 +0530
Message-Id: <cover.1696791459.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset series consist of fixes to issues found by checkpatch

Pavan Bobba (3):
  staging: vt6655: Type encoding info dropped from array name "abyBBVGA"
  staging: vt6655: Type encoding info dropped from variable name
    "byBBVGACurrent"
  staging: vt6655: Type encoding info dropped from variable name
    "byBBVGANew"

 drivers/staging/vt6655/baseband.c    | 40 ++++++++++++++--------------
 drivers/staging/vt6655/channel.c     |  6 ++---
 drivers/staging/vt6655/device.h      |  6 ++---
 drivers/staging/vt6655/device_main.c | 24 ++++++++---------
 4 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.34.1

