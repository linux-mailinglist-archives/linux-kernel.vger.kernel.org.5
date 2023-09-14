Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C6F79FD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjINHfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjINHfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:35:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BAFF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:35:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fc081cd46so613682b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694676926; x=1695281726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xubQqDqE3MPUGgTOZQ+MDnXD04/AvVIaIiqtNTzF60E=;
        b=jEpLWD8c2mtpTE9V5bsGQSYVv6oEQuq23yXkZvTqM+YFyZ/aVOrSLQp8hiwRhtb6gp
         sd54+uN+TZ3jK/iZYX55mZL/fF46Ni6j8R+HFUm+rCJeSgt16dGvouVRqndZAEkBbE4d
         cgn/FfBANec92hdaqmwGEHi9sUiTDSVxnQ2vP8yv+41dFxVA5LSj9Dd4opKBPE5sGQxU
         gsuupiVTCK1QMfv6+9rgRjVvUrP1FbWgkF0Fq84B//iSjqZSIcF8niXlc29OQDeu3+3T
         afK5F/h1SzOSLnDbRLb0Sy/Az7+FJYnBkiy1gJBtMXUw08oHLkLL1/ARhKLUuC2VRRGL
         p6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694676926; x=1695281726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xubQqDqE3MPUGgTOZQ+MDnXD04/AvVIaIiqtNTzF60E=;
        b=ApEgRTiKbpD3ilNSGelr8FIitOs8nMYSYMufg4UWQMbCSHVa+mYaIfRrjZVl3Ktuc6
         P9yXaqhdSgUYE99HxkY7+Nb2SCJljGHmb9/NjMI0FOA1AlYv3IF4ci7pvefCapNzO/Sw
         bop/eEIqqwFH9F9Y4+iU74Tz52xGe7ZmWDE1HzZe6zXVEOeXD7pRJqw3HFLquqFfsM+a
         4qrCPI+xMVWJEObLkem7465QXYEQp7mC6THXllNPIC03Tu4b5OswSl/GKEM+/Mo6hw76
         3vJWtw1uuPR5jV+l4KxrOYD3TbVj3xgKshSeTuWrUThy3sDwGS++J2hYR/B3xW8C114s
         HHeg==
X-Gm-Message-State: AOJu0Ywhne/PG/cEkgYcFrypkQDimi1gz89addv60ylErmUivOilrUqc
        qU6u4Duc83PvQXJcJpIfvQ==
X-Google-Smtp-Source: AGHT+IGoxtU3KMYfSUOaFc3lKNFVicrbEL82z6S8UyrdTcbFH0kl7EI5wwDzRpvPrFpAUN+rndftHQ==
X-Received: by 2002:a05:6a20:840c:b0:153:78c1:c40f with SMTP id c12-20020a056a20840c00b0015378c1c40fmr5434699pzd.15.1694676925639;
        Thu, 14 Sep 2023 00:35:25 -0700 (PDT)
Received: from svr-pkl-eng-01.pkl.mentorg.com ([110.93.212.98])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001c0aa301703sm859840plb.63.2023.09.14.00.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 00:35:24 -0700 (PDT)
From:   "Arsalan H. Awan" <arsalanhassanawan@gmail.com>
X-Google-Original-From: "Arsalan H. Awan" <arsalan.awan@siemens.com>
To:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     arsalan.awan@siemens.com
Subject: Re: [PATCH] soc: ti: pm33xx: fix resume from non-rtc suspend modes
Date:   Thu, 14 Sep 2023 12:34:21 +0500
Message-Id: <20230914073421.3065114-1-arsalan.awan@siemens.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831151232.4169624-1-arsalan.awan@siemens.com>
References: <20230831151232.4169624-1-arsalan.awan@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any feedback on this will be greatly appreciated.

Regards,
Arsalan H. Awan
Technical Lead | Embedded Linux
Siemens
