Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788C78F2E2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbjHaSs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbjHaSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:48:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746AEE65;
        Thu, 31 Aug 2023 11:48:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401ceda85cdso11947115e9.1;
        Thu, 31 Aug 2023 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693507703; x=1694112503; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahmrOVqwwJFu3WxpSfgce+G5opjA33YS4PMyyXAd7ms=;
        b=Z2FEbL3oRxeE9HwrgpteMUjjhurGOKIfIfcXK14EmAqC0ic6i0UexnRUgui8+o6QDe
         TewuhOn13t+C/jRFh3BpUfAfEtD6DHOc2Midg1pO9gs36qOrr3gr5HUM+fQP/jTmbj3f
         gn2Rf/UygTuI6bdhBXE9WPxzhbxR9IuCNJUOc2Qedqu79lCSKzFHS4ZxEdy0sW+rARUy
         jVw6J3Qc1jqnyBKnEbyr3aC/qeV7s1i/VCKBxTAKUTklKuqFxfUOWkJ/7CVjQlT43Qr8
         GPJ4zYgYAWGdAFAVPXb4rPNIOntcYZwHnmcKkSce6/zUaBKigsJ40HhgZpVjflLLitCb
         D0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507703; x=1694112503;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahmrOVqwwJFu3WxpSfgce+G5opjA33YS4PMyyXAd7ms=;
        b=H7L/XCcNf8RqD2HEUSRbFFfDwS5LE1hY9kABUs3c2k8sUkVHhxCgmfEdSMxJfvp7YY
         9l4E55uW0ir8GOUStmph8LdeoDN/gk102htzzWVADb+/YSz6puRcCDCFy6ki1TZzAHBJ
         oyhVYVMBwTpZct/e9/pqztproUmwPnrmsdXooA9791yQzOqolLvt+ChjunM6SUcQvBxM
         ExVy0Lr0Lx1HtuGyLK+QYfeGW9gxyuwruzVjKkBOCpNao3gJbAcS/t2Fv/XRc74uaNst
         VritagtelZGRXF7M6D8Ev+5ke0hyVaVFRVr29C6Jp0ZBIAHexVer56uK8KW46wx+ACgh
         Zoaw==
X-Gm-Message-State: AOJu0Yz1GWVoX8cFYqKBJiCUkj4R5aoQEbIZjznTawF7GfjffYsThybO
        dRDKyAdbaHfW7XI7So0XmkDifnMCvFc=
X-Google-Smtp-Source: AGHT+IGfZb8579Yjvtnal5tdT/GYaF1cGdV5xTKFKo1tpdq7EudzAt4mbBHbPvzHbNAvuygNNe1mGQ==
X-Received: by 2002:a1c:7911:0:b0:401:4542:5edf with SMTP id l17-20020a1c7911000000b0040145425edfmr181282wme.0.1693507702525;
        Thu, 31 Aug 2023 11:48:22 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id o24-20020a05600c379800b003fed70fb09dsm2745829wmr.26.2023.08.31.11.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 11:48:22 -0700 (PDT)
Date:   Thu, 31 Aug 2023 19:48:20 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
Subject: mainline build failure due to 501126083855 ("fbdev/g364fb: Use fbdev
 I/O helpers")
Message-ID: <ZPDgdGBbxrTl+m2s@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build mips jazz_defconfig with
the error:

drivers/video/fbdev/g364fb.c:115:9: error: 'FB_DEFAULT_IOMEM_HELPERS' undeclared here (not in a function); did you mean 'FB_DEFAULT_IOMEM_OPS'?
  115 |         FB_DEFAULT_IOMEM_HELPERS,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
      |         FB_DEFAULT_IOMEM_OPS


git bisect pointed to 501126083855 ("fbdev/g364fb: Use fbdev I/O helpers").

Reverting the commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.

#regzbot introduced: 5011260838551cefbf23d60b48c3243b6d5530a2

-- 
Regards
Sudip
