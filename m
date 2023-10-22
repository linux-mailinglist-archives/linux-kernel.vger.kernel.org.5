Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730547D244D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjJVQUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjJVQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:00 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F00E1;
        Sun, 22 Oct 2023 09:19:58 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57d086365f7so1584190eaf.0;
        Sun, 22 Oct 2023 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991598; x=1698596398; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ot75iBZaZUeJ5MEWunC8jIOcs8JwsIEUJRHg5ojxiKo=;
        b=YN1BFlhEJnsQms0aNNnwx6W3lInmO+aVGqbQ4UnPVIasWyM0pZOLB/dEpFIMVH6ZQU
         DCq3OADVV1ed/QDEESv5NcDTUKHm3o81iDU444QUAasgVeGye02FijAoWBzbDrCWhVlP
         Fo0bMvC6RT9St2cZmhYB4VFOosyr0METtY82zWYMFmsn+C1kfqF2SejruXAK+OyhTd4G
         sPAA0Z97iqVcYlobjQWEjavvHpzzyVII17JPt4Q0tdclGcX/IC44n5u+ZdbfmENagJFJ
         UIceqQLUiSSOWykEW9K5bjxLPAupIG0t51sNQKYfak2j8Rc/bciuF73AzBrNawB/ASD+
         aegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991598; x=1698596398;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot75iBZaZUeJ5MEWunC8jIOcs8JwsIEUJRHg5ojxiKo=;
        b=bfGmlENfMGBVnOnJpoNoinb34Ua4U093cgV7jj6bmZM01zRbl/xjoJXc5N/8daII4H
         fJPFy8MmCmW7NxDigPk7wBaBlVj95oRijJFB6z+VR1vgPWLEH3Z3iOrTfjEMofnkg/aY
         /Gz0LP0Q0w4RxFzD4G3y7RieAOznzfSTCLOVYy1OW5Ek+KT+YU9TL1OYbcbcYOccKxDS
         7IBYb1XB2pbJrwdK+Y6Wxdz3d67fIeJK8xVHrlefg9PkR5WNtwGmr/pRq25i8Mbi+FYd
         X8wReQdU/oBq1tgIu/M9oOyLHsGf+uC8FKoL4SMfoReI3FhaGxDSR/kE4Vp9++V5h3RJ
         1r5A==
X-Gm-Message-State: AOJu0YzA53p1NRqppn0XA2uoy7yATpGtvv+mhfwNhZxIQo6D3+tFCGwS
        M70+pgstrlNeCgYuCl190Emq8N1+2SC1pJom
X-Google-Smtp-Source: AGHT+IGXkVzwrQC64A/3aNw8JIkf5iZEaBnyeiNQwAz8Obm+W5cpMvuzccQmVnyiYNhRYoq6JBNb2Q==
X-Received: by 2002:a05:6870:5252:b0:1e9:8182:a29d with SMTP id o18-20020a056870525200b001e98182a29dmr8669730oai.41.1697991597843;
        Sun, 22 Oct 2023 09:19:57 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id 10-20020ac84e8a000000b0041520676966sm2119718qtp.47.2023.10.22.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:19:57 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:19:56 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 00/17] Change cork to a pointer in sockets
Message-ID: <cover.1697989543.git.ozlinuxc@gmail.com>
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

This patch changes the cork field of both the inet_sock and inet6_sk
structs to a pointer, reducing their size.

Oliver Crumrine (17):
  Make cork in inet_sock a pointer.
  Allocate and free cork in inet_create and inet_release in file
    net/ipv4/af_inet.c
  Change cork in ipv6_pinfo to a pointer.
  Allocate and free cork in inet6_sk.
  Change occurence of cork in inet_sock to pointer in include/net/ip.h
  Since cork in inet_sock and inet6_sk will be a pointer, they don't
    need to be referenced in this function in include/net/ipv6.h
  Change occurences of cork in inet_sock to pointer in file
    net/ipv4/af_inet.c
  Change occurence of cork to pointer in file net/ipv4/datagram.c
  Change instances of cork in net/ipv4/inet_connection_sock.c to
    pointer.
  Change instances of cork to pointer in net/ipv4/ip_output.c
  Update occurences of cork to pointer in net/ipv4/syncookies.c
  Change occurences of cork to pointer in net/ipv4/tcp_output.c
  Change instances of cork to a pointer in file net/ipv4/udp.c
  Update usages of cork in net/ipv6/ip6_output.c to pointer.
  Modify occurences of cork in net/ipv6/raw.c to use a pointer
  Change usages of cork to pointer in net/ipv6/udp.c
  Change instance of cork to pointer in net/ipv4/tcp_ipv4.c

 include/linux/ipv6.h            |  2 +-
 include/net/inet_sock.h         |  2 +-
 include/net/ip.h                |  2 +-
 include/net/ipv6.h              |  4 ++--
 net/ipv4/af_inet.c              |  6 ++++--
 net/ipv4/datagram.c             |  2 +-
 net/ipv4/inet_connection_sock.c |  6 +++---
 net/ipv4/ip_output.c            |  6 +++---
 net/ipv4/syncookies.c           |  2 +-
 net/ipv4/tcp_ipv4.c             |  2 +-
 net/ipv4/tcp_output.c           |  2 +-
 net/ipv4/udp.c                  |  8 ++++----
 net/ipv6/af_inet6.c             |  5 +++++
 net/ipv6/ip6_output.c           | 10 +++++-----
 net/ipv6/raw.c                  |  4 ++--
 net/ipv6/udp.c                  |  4 ++--
 16 files changed, 37 insertions(+), 30 deletions(-)

-- 
2.42.0

