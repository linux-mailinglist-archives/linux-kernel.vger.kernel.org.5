Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021507BC499
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 06:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbjJGEMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 00:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJGEML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 00:12:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2726FBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 21:12:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c877f27e8fso22635465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 21:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696651929; x=1697256729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZXl4fZOZGW6S4QLpiluo7ub/jMSf5d18x41Dh4pVsY=;
        b=glsiKpdJrZmJ4caPvGoW8B8n5fHOLSiFIRfOe89tE9+yCuoNSBld1/sfbWTb8CKmPc
         cPEzKfD+XlsLkRD9F9hMv3PASOeYRgvWPhBQupzWddxH4zeQvKtzhmNHiP1Ak+KEMqW4
         XWjtj0aF0/Ltkm2Uw0Ac0u8yJVwMayWdGbucA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696651929; x=1697256729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZXl4fZOZGW6S4QLpiluo7ub/jMSf5d18x41Dh4pVsY=;
        b=YpRuxc7rkz/WoW+X1xA44dt82Lil3Chrf7D6sxSXnezBqT3a6JoMToE24OEW2cPfNV
         zmjbXdDe+e04aLGp6SaWghKDv/gPHPhmEXbu7gp7IRfUBHJ54+Ewqb3q1F4J6lj+7JmK
         EukFlLSzmhtR8M7SEAWlbi4+pW+wjy+Zu8d2tkcH7heTgWevf8GjyDLg2EMVFW7BMpwX
         xX8vYh5tcmYLJG3CdqtO1Rh29w3n+ADWIF/gOdptZdtqW5AvjgMWAAsUthiDyrbL/iT9
         gNCUqIolr/56800he8iPRC8utNTS5hebi12n/G7aGVW55Wqi7ym4WV0gwzUOE7OOFVDg
         TwZw==
X-Gm-Message-State: AOJu0Ywo6xhj+kZyzhqWsX1GrSxsSz1wC7Qjq8F41t7waOl/h9PWL0Vz
        vKdbxsRB1ISddYyod7X+EoGC2t9RAUH6dHSc/rQ=
X-Google-Smtp-Source: AGHT+IF/ZipK2R7tGfd625n03Z25S787onFBu5JyqaUiGZOKjSrX04s0bRLQ8heHgUE/EU7Spolwug==
X-Received: by 2002:a17:902:e749:b0:1b8:76ce:9d91 with SMTP id p9-20020a170902e74900b001b876ce9d91mr12712347plf.1.1696651929605;
        Fri, 06 Oct 2023 21:12:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ju8-20020a170903428800b001c72d694ea5sm4757330plb.303.2023.10.06.21.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 21:12:09 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:12:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lukas Loidolt <e1634039@student.tuwien.ac.at>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Subject: Re: Missing cache considerations in randstruct performance feature
Message-ID: <202310062111.809AB4E56@keescook>
References: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 12:30:01AM +0200, Lukas Loidolt wrote:
> In my tests, however, the performance version behaves more or less like the
> full version of randstruct.

Can you try this patch?


commit d73a3244700d3c945cedea7e1fb7042243c41e08
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Fri Oct 6 21:09:28 2023 -0700
Commit:     Kees Cook <keescook@chromium.org>
CommitDate: Fri Oct 6 21:09:28 2023 -0700

    randstruct: Fix gcc-plugin performance mode to stay in group
    
    The performance mode of the gcc-plugin randstruct was shuffling struct
    members outside of the cache-line groups. Limit the range to the
    specified group indexes.
    
    Cc: linux-hardening@vger.kernel.org
    Reported-by: Lukas Loidolt <e1634039@student.tuwien.ac.at>
    Closes: https://lore.kernel.org/all/f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at
    Signed-off-by: Kees Cook <keescook@chromium.org>

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 951b74ba1b24..178831917f01 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -191,7 +191,7 @@ static void partition_struct(tree *fields, unsigned long length, struct partitio
 
 static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
 {
-	unsigned long i, x;
+	unsigned long i, x, index;
 	struct partition_group size_group[length];
 	unsigned long num_groups = 0;
 	unsigned long randnum;
@@ -206,11 +206,14 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
 	}
 
 	for (x = 0; x < num_groups; x++) {
-		for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {
+		for (index = size_group[x].length - 1; index > 0; index--) {
 			tree tmp;
+
+			i = size_group[x].start + index;
 			if (DECL_BIT_FIELD_TYPE(newtree[i]))
 				continue;
 			randnum = ranval(prng_state) % (i + 1);
+			randnum += size_group[x].start;
 			// we could handle this case differently if desired
 			if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
 				continue;

-- 
Kees Cook
