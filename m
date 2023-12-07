Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7221B808B70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjLGPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjLGPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:07:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75242D59
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:07:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce6dd83945so627664b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701961635; x=1702566435; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZPF962lXavs4LecESKaTLt6HdfoXpSpOotG4VFvnDw=;
        b=ZkSn8+nWY96TbWvXxlSUIObuKhFfqK1LE+JiRG+o7OYrUNHtzgXOj2qp7QlVCr9FzR
         I3KPIVruxgAyD0+lOUawc7A8Lm1A3+Qn7P/klBoLFQmF0KroNKuoJS0E5Hvq9d2VBeC5
         DwGXz2S74Oc8xmevRcKG8QQiT82nZ+tt+aUIid2V4pto+oBcprkULVtAIBwMJD7NKW1K
         O9xkmgkQRJSuHUEPs2KlavFVtB8/LXfjPNv3SPOPzpvsza+a8nMBHwwY2cqzmf6+4DTM
         v+lWXVqyZ/w7V7WcJGyE2hadnMgtKRAXr7RQxg9HPQHVjRaipZkaypZoWIWYoP9i3KmO
         eYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961635; x=1702566435;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZPF962lXavs4LecESKaTLt6HdfoXpSpOotG4VFvnDw=;
        b=PZ1cKiVdQiZwGxVWHK8zDzsiGXIZsIQYTuv+wvcDGhkNA/cpNVQD/hujtD+0fw9oAY
         duTVQJ1jwH8D3zXDybR7wzzt4D7lDqPaHgaB8aGOPKvP/Pvpfhru0Cg9juXVZhiAxgbL
         T81NdSXfenD/1Yu7LcjHlvsZ1/0YRwWtErPZ+S32bgq12dfb15cMrepg7keXYKC0wX9s
         1uYyIC/tiThUDYhvSLXK6bZ2vQbWi+8x3949+o5g2s2+AXNhfEpI+41aCjXXDEh8dwWU
         nieIsZgQS68SCBBvpHNiJy9KTs7ppHlpN+lH1TMsd3QqRvkZqcvG7hwv8zFeZIUl2/qI
         hZgA==
X-Gm-Message-State: AOJu0Yw2Jf2zIwzysxlbhENiDTq2I9R+PwiQBcI82J73mRpyJeemV3yj
        ZpBi5xk7YKajRnwBoZBE0RR7zvfHDh7z7RrMAiHGlQ==
X-Google-Smtp-Source: AGHT+IFeDLFm4/ox9OEcay0E+2CrGOLfCELaHKQrl+v+mFmvEF7verRHXrwXCmQBat0HYdXuSbkuDg==
X-Received: by 2002:a05:6a20:2618:b0:18c:9855:e949 with SMTP id i24-20020a056a20261800b0018c9855e949mr2417031pze.15.1701961635507;
        Thu, 07 Dec 2023 07:07:15 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:63d0:ab90:5481:84fe:12c9:eb0e])
        by smtp.gmail.com with ESMTPSA id e7-20020a056a001a8700b006ce4b40e7desm1452749pfv.90.2023.12.07.07.07.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 07:07:15 -0800 (PST)
From:   Gianfranco Dutka <gianfranco.dutka@arista.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Message-Id: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
Date:   Thu, 7 Dec 2023 10:07:13 -0500
Cc:     vincent.guittot@linaro.com
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon maintainers and subscribers to the lkml,=20

I'm a bit new to kernel development but I had a question with respect to =
the kernel parameters: isolcpus, nohz_full, and rcu_nocbs.=20

Basically the question is this, am I able to modify the three parameters =
I mentioned above at runtime after the kernel has already =
started/booted? Doing some reading online it seems that it=E2=80=99s not =
possible but I wanted to double check with the maintainers if there =
wasn=E2=80=99t some sort of change in the works that might make it =
possible. If not, what would be required to make the change after =
boot-time through some kind of patch or something like that? Would that =
be something that might be valuable upstream?

At the moment we are running an application that might see some benefit =
from being able to isolate cpus on the fly without having to reboot =
everything every time we want to modify the parameters mentioned above.=20=


Thanks,=20
Gianfranco=
