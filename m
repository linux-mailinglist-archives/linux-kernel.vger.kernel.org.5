Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C472758121
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjGRPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjGRPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:39:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B42B0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:39:40 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-262dc0ba9ceso4461674a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689694779; x=1692286779;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGGkQ93IrX/9raMIEPjF/6hOzBaxFMRVgXqy35n2HSE=;
        b=KyQeYVzk+K7gK1oqThDjsWR9LCO7EnjRY1G1/yz2WnYrK/fkZgDCsGnQBd9IX/GOGR
         iQ8f5J6QyrquJGh3kja5Ey/Ga6ZvFcIomujIVZEJ5YVsosOwkHkUL9wMMQA1cAGyAWGX
         FERgIPhfquufTAfTUl2uLgINmRfEkasAo4RpkWWDqiunvUpXP2vvLsNsDr0R/ynvDioE
         7LXHHyooxZ2eYKvJYQT9/byUuj/f8kQU6N7a9fPp4bc7OcDOG+VwqJ6HnWwqC+0ZNlbi
         ahHtg7BosB+Swt2i8eKv+YgU6R8Fs3nSx1FseOWnU7jgVtPWVrk82FAXpQHU215xeDzY
         2hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694779; x=1692286779;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGGkQ93IrX/9raMIEPjF/6hOzBaxFMRVgXqy35n2HSE=;
        b=KrX7wAsoK+QjSO2gqypB68kSbpH5NA6oK2g+MbT+GFq/gael14wvg+IgIAZVpIYp2t
         NFMAT8WrzPVgMTbj397yBtDeMUSkBW3wPM2LuI+mvXx4509PjbdXqKrHT9HZYkBgESXy
         ZkLDp1p/2P/6JQ3azgpx25d1vTUqo36MV+vsuBvb3Hrawwd4LCN3bxwkHgk/fk0cQkV+
         Kj+gsLmp31Tyy3kKur/uMqFot2sCvFVY4AO2euZCqu9j9U6Ot52TfqEyhdtZZApBNzZz
         iFXlNlR0jEgEVwF3jfMXBLItT3KkYwO06Hagus5mMgZKu0j9HOP9wOAN1abLADDDBnsO
         C4/A==
X-Gm-Message-State: ABy/qLYMfqLXkmHnFUrlIGnbWPm9+xfmVWczeAyR8rCM6ajeSSOcL3ve
        1NHdp2gz0cOKjuhl3KpDdqSHhdC4+dE=
X-Google-Smtp-Source: APBJJlHZt7kp73Z7e3TtDTE2aH9PlAuzBAHS8EzXh/6Sg6h/6nchnKopI6IxRXZJiyn5TPijVukeYHsZXV0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c20c:b0:262:d1ce:e06c with SMTP id
 e12-20020a17090ac20c00b00262d1cee06cmr118559pjt.9.1689694779499; Tue, 18 Jul
 2023 08:39:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 08:38:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718153828.1469689-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.07.19 - LPC MC format + guest_memfd
From:   Sean Christopherson <seanjc@google.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Topic #1:   KVM MC format at LPC 2023 (~15 minutes)
Objective:  Discuss and (mostly) finalize format of KVM MC
Background: https://lore.kernel.org/all/ZJ3zU52uK0N+uoDn@google.com

Topic #2:   guest_memfd development sync (~45 minutes)
Objective:  Identify known issues, build list of todos (and identify owners)
            that must be completed before merging, and hash out how to
            (efficiently) maintain and iterate on code while it's out-of-tree
Background: https://lore.kernel.org/all/ZEM5Zq8oo+xnApW9@google.com

Date:  2023.07.19 (July 19th)
Time:  6am PDT
Video: https://meet.google.com/vdb-aeqo-knk
Phone: https://tel.meet/vdb-aeqo-knk?pin=3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link

Future Schedule:
July 26th   - Available
August 2nd  - Available
August 9th  - Available
August 16th - Available
