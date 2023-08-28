Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23478AB43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjH1K3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjH1K3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:29:21 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E81AB;
        Mon, 28 Aug 2023 03:29:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d77f614243aso2904269276.0;
        Mon, 28 Aug 2023 03:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693218558; x=1693823358;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=rfuWXr9RYqSTqpdcnXC8wIF8SIgW9XCso4FybJhi+1f8rlYX3lS9xSfuQ5GS6kGWv6
         cUqbOF+ILTK56ca6scH5XkOUa6qAh0lGMnhAdT/HjK6VNShySApPGXxTSX1AXDr4b4zW
         QcLxlz8dRwHlKQ0sboX4/Ux2SC9QNtcuIVudhSTewpVWe0MzdMgHElj+sL6L18gMCBN2
         ntWHVhDEMYxjrBew11z6qQYrt18Vm9WRNlUEOetv6e6iskK3x83zw4gOarvmxpO1fYjQ
         wxCZy2KOjvjVFgR6gQ4gjHpwdoEPQ1FKsbfZICoJfC5uSFnA1lEIGCxOnMyhcLiXNK+j
         fumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218558; x=1693823358;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=AjSrF9zawkQzdKiP1xwm7Kb0crLCoB7G/zBYa8UI6I/i+W95dfNyHd4Z70XPBQvvVA
         J2ZFF5R9NikdvkR4nkYWXhUlayxDrcXVDhPVkj4in8qhL+EGQIuMJDbh8MSk7Dbsc8Wt
         BTQUGh/nRSnRVuFMep21KqnL1SxN5YZKQ6s2k3FIKF2ue7KuFNo3RfLOWHhC9Ag5xDSF
         GudWsJrhOI135mY6huB+CZQYylahHOYdWuMmFns85YZVMMxWe+jY6BqsvZFtOEQrtxcH
         XpZgwQctzh+PrGfiV34DiusIVxR9CCLKeMDT697jJP+zzXScKGxsYlXbYaj9DijUa9HQ
         /iKA==
X-Gm-Message-State: AOJu0YzUF7Oc2bYv58odQGNwDmX7O1G7UoJ4EZmFWuSZCTAnbk4yNEnH
        pgZKJVLw6LLramTB6bNuLS3Su9VPBvcpjdWDvgg=
X-Google-Smtp-Source: AGHT+IEYJiSsStK+vCSKjS5iWTldKDDxV5CSkV7Jdpf2lqnjpuhL85UjFgf9YZMcEWHIuk5Y09uEJxtmN5bdN30RQ3I=
X-Received: by 2002:a25:68d2:0:b0:d77:f613:30ec with SMTP id
 d201-20020a2568d2000000b00d77f61330ecmr11735576ybc.54.1693218558409; Mon, 28
 Aug 2023 03:29:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:5bca:b0:4fc:b2ea:2904 with HTTP; Mon, 28 Aug 2023
 03:29:18 -0700 (PDT)
From:   Itzel Campa <ariadnev95@gmail.com>
Date:   Mon, 28 Aug 2023 03:29:18 -0700
Message-ID: <CAOYsRdesXdDWttZv8N80HHu46MiCoq=KDrR6z0R-to4ojt+wiA@mail.gmail.com>
Subject: 
To:     francesco@dolcini.it, accessibility@support.whatsapp.com,
        alexavillegas893@gmail.com, contacto@becasmexico.org,
        francesco.dolcini@toradex.com, j-luthra@ti.com,
        lifelinecontactus@mhaofnyc.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, ssantosh@kernel.org, support@whatsapp.com,
        support@onlyfans.com, titohoto2@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


