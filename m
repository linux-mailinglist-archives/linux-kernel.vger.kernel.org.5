Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4837B4BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjJBGrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjJBGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:47:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81FFB4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:47:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5048156976cso8761537e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696229250; x=1696834050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3BqCO4mWF10nilDa/c4wHmj/s6v9lbe+j6TGDexzDI=;
        b=EuX8Pc3FTc1pITBbeBTuE+f39kYwVQBAt0DZymHG3+AV09Ldg0btaqP2PF1ug0K533
         P1w+WkbuwV14z16Vul0Gk7HaYkbWiUxtfo2fZFgAvBj7Ra76K/4XlHn3Drh0/G33j94A
         zDfYRa+cu5R8fqs4c2cl3GqMd48gxVfpg6QsLfv3es0pr8xR1I/kDdeGHbT+QiOtTaOB
         u6NKFOo13IPxuVcY6pnZMP6Df58las9sZr/IXpPWBQRerP1fZQviGwQX9gJXVhBup5LB
         SsPHjFi9STzVx0BgEh9wkZk2i9CX6rn8Pbcdr6WRy14KNYUuqIUtwY3WTDlbWc5Jahv1
         nlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229250; x=1696834050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3BqCO4mWF10nilDa/c4wHmj/s6v9lbe+j6TGDexzDI=;
        b=drlYN/MAe5NqP39CwCWhcAOzWnBKiCHWyJ014s863lDrAFstJs2lMPTsBZplt68Y7Z
         R8F/inHbDGa9puqfGHecRiwuARJ8JtbFsQjX8oSjcQgaJiDTNXgAOqhawzlJWj/lteAE
         ipoivYesiuRxwOASEjjFCc4kLfbBJz6JYbAzsbNLwDCu0IBLWvgzf8KUKkec9uoqn/rc
         lEdaH0VEA3XWTABz5UotqUX7aCEVYU4BcCVp91uVqSlhGz2qz7NY0Iyh1BjFUFWoZ/ME
         eaN5J+jzTeibznEnvpshka3unIB7negxkqkH9RVOJP6toxQf+pKbS0y2rYOO9wazsqVo
         Gypw==
X-Gm-Message-State: AOJu0YylVEAudOsYhPjqovlB3jy/soXthV0GisYnLJVZiOWMNMzMzW/v
        hK4kf6Qr5hreizcIr/7kPao=
X-Google-Smtp-Source: AGHT+IHsxKu3Mwdi8HUlGe8r9wq8AQQVFVKf9Si3zNtkB00GPO9m9ZUV3I2Ppi4/1jHfKMNdCpJj0Q==
X-Received: by 2002:a05:6512:3e14:b0:500:c128:66d4 with SMTP id i20-20020a0565123e1400b00500c12866d4mr10113631lfv.67.1696229249682;
        Sun, 01 Oct 2023 23:47:29 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b003fe29f6b61bsm6623325wms.46.2023.10.01.23.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 23:47:28 -0700 (PDT)
Date:   Mon, 2 Oct 2023 07:47:28 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/filemap: clarify filemap_fault() comments for not
 uptodate case
Message-ID: <2c7014c0-6343-4e76-8697-3f84f54350bd@lucifer.local>
References: <20230930231029.88196-1-lstoakes@gmail.com>
 <ZRpiiq/pUB6hGTl/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRpiiq/pUB6hGTl/@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 11:26:18PM -0700, Christoph Hellwig wrote:
> > +		 * If the invalidate lock is not held, the folio was in cache and
> > +		 * uptodate and now it is not. Strange but possible since we
>
> Please don't spill block comments ôver the 80 charater limit, that makes
> them impossible to read nicely.
>

Yup this was because checkpatch ok'd it, I've aliased the strict 80 char param
so it won't happen again.

Fix patch enclosed

----8<----
From 3abb740abb67505b6f83d7602f7b4a8dcd29977f Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Mon, 2 Oct 2023 07:37:24 +0100
Subject: [PATCH] mm/filemap: clarify filemap_fault() comments for not uptodate case

Correct identation as per Christopher's feedback.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/filemap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 959694a2ade7..951709089f38 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3314,10 +3314,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	if (unlikely(!folio_test_uptodate(folio))) {
 		/*
-		 * If the invalidate lock is not held, the folio was in cache and
-		 * uptodate and now it is not. Strange but possible since we
-		 * didn't hold the page lock all the time. Let's drop everything,
-		 * get the invalidate lock and try again.
+		 * If the invalidate lock is not held, the folio was in cache
+		 * and uptodate and now it is not. Strange but possible since we
+		 * didn't hold the page lock all the time. Let's drop
+		 * everything, get the invalidate lock and try again.
 		 */
 		if (!mapping_locked) {
 			folio_unlock(folio);
--
2.42.0
