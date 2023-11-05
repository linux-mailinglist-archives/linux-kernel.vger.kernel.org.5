Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B017E13EB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 15:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKEOel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 09:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKEOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 09:34:39 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B409E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 06:34:37 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2e7b41beaso5398797b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 06:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699194876; x=1699799676;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lovrfIQmQ8Nc+eRafnP/oql/XRfon5MgJIp11Am8EkQ=;
        b=geEqWg5EkQTPdbtSWo9mxRVj505TksygPmUvTWBQOIgItFKRle/AGzgyb8vTJGhbpf
         RXp35+l4nvUxy3iOWwI8Y6qKUDAMLnqzQAmj9IFN+oT8HJqetpqSlKKMlgMEG55VHHkD
         K4bV8VVSOJiv88c/SxFogLC8o+Pejtnz+rbfE8zI2Udvob5aqD0wi2j7z/UyuwyuD3Ql
         PGxFZFerCGFoYrqKl2/me5GEdt1DdWp2BdHtJyTd4EsTqBWcErl1yENdqu9Qy53wce05
         s33Er8aD4m9c/z8xH2BeCAg6a/919aohZ8LKhzSuP6QVOrbDezQL1vlBHeO2UwjcRtGt
         8mow==
X-Gm-Message-State: AOJu0YxX2UBXDpd1eXeQn8XcfK/Coj9yWRd1DFsCqHrN6yzJFVywJb0V
        TX3KYxZHDyeHKi2GTRq16HhzM/CHSDx5vVI8KnIHYxfGa+5J5O4=
X-Google-Smtp-Source: AGHT+IGp3Tj2rHIrvBVAqzLbmOT+cNE1h6bTKNnTAKAO+P3/0rOgjmJPElnCyhN77vAWRqgxadQOMh7pcpP+6ajdaKr2iYzHcWCd
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3096:b0:3a8:45f0:b83a with SMTP id
 bl22-20020a056808309600b003a845f0b83amr3430408oib.5.1699194876329; Sun, 05
 Nov 2023 06:34:36 -0800 (PST)
Date:   Sun, 05 Nov 2023 06:34:36 -0800
In-Reply-To: <000000000000b37bea05f0c125be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000204af060968a366@google.com>
Subject: Re: [syzbot] Null ptr deref
From:   syzbot <syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Null ptr deref
Author: osmtendev@gmail.com

#syz test
