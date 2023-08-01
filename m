Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1518676BBA9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjHARu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjHARuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138D01FDA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690912177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WCyW2xPGvGn2KArLxMejeAbnztOOe9Ja2AC5dTRufnw=;
        b=JOaHBXQzLcTmSgvViOjkVIQxhBcpmV72JAu7W3TiUH1+AJwFPscUXiwN9jBS+6w4MqtSjB
        uuPKwGA7bg1KGpE8/8mcMjDopCYSxY2Ta2kklPXGfalofimtTj2viYd/AGqqoRv3ozgm0M
        Yi+396ugqlnRtTerYtaRA9qkZz4x2L8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-pH2inu_OOnybcUt1dSOtOg-1; Tue, 01 Aug 2023 13:49:36 -0400
X-MC-Unique: pH2inu_OOnybcUt1dSOtOg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-583c1903ad3so69967557b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690912175; x=1691516975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCyW2xPGvGn2KArLxMejeAbnztOOe9Ja2AC5dTRufnw=;
        b=QbX+7D2fzMtf73uIRKIhXhxnAMNyUf+souplr4o9Uy2FeX9kX0/ODSYuAuGI5kx9u8
         +cR9cPPA/8U583RxjnkqE4WGakt6zkHbPI4tqat6QKHc5tEDHV7N91/W/esY77B4m4N7
         Mq5cH8stw+nPKMszGz9nHpHxeFRw4f5IHsT75xF2mYCfGWL9LLbfHqfg8dI29KpL6mDo
         8eNUwBO0aiz7kfRITitFBXA9q8X2B9IWDmG4osbewJIYIP103CoGuyBKSFQ6BhKpALJI
         JyU3XklfMDeMLluUu93Ceb+rompjUt7sSkVIBeNnUDbFqJQvwg32O/61mrbj9S8KQIXN
         t37A==
X-Gm-Message-State: ABy/qLbVYday0kScALeQqwcf0cRJgscwrsKctZ0Qs1yZy9uGQpzN8xA7
        QpSAZsYwI5yXl6zaIDBM6a+4DXggSUcAupzeZVjk/NRdMxB0bDJMdRFzEM3qKZAItSDG2ZzwKPS
        RbOuCTJvdaT7KvbMuHzuVbopd
X-Received: by 2002:a81:7545:0:b0:56d:2189:d87a with SMTP id q66-20020a817545000000b0056d2189d87amr10919470ywc.15.1690912175523;
        Tue, 01 Aug 2023 10:49:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE8Hw8Au5SbYBh3YUWTcg3E0mgPPknqhWJLpoxWy4nSR/rPLCcPgcfXi6Si9PBB/67pWc1+jA==
X-Received: by 2002:a81:7545:0:b0:56d:2189:d87a with SMTP id q66-20020a817545000000b0056d2189d87amr10919458ywc.15.1690912175223;
        Tue, 01 Aug 2023 10:49:35 -0700 (PDT)
Received: from brian-x1.. ([2600:381:222b:e67:295d:9324:c84:3382])
        by smtp.gmail.com with ESMTPSA id k187-20020a0dc8c4000000b005773afca47bsm3881728ywd.27.2023.08.01.10.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:49:34 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 0/2] scripts: add two new scripts to look up Kconfigs
Date:   Tue,  1 Aug 2023 13:49:20 -0400
Message-ID: <20230801174922.333700-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's two new scripts that I think that other people will find useful.
One is to look up a Kconfig name based on the module path and the second
script looks up the full Kconfig information based on the symbol name.

Brian Masney (2):
  scripts: add mod-to-kconfig.sh
  scripts: add kconfig lookup script

 scripts/kconfig/lookup.sh         | 77 +++++++++++++++++++++++++
 scripts/kconfig/mod-to-kconfig.sh | 93 +++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100755 scripts/kconfig/lookup.sh
 create mode 100755 scripts/kconfig/mod-to-kconfig.sh

-- 
2.41.0

