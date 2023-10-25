Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3224D7D6633
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjJYJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjJYJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B220C12D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698224593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=Cz0D94VXreSreQRMfQNLE/Lbm6TagmgrnitLffgb/QkVlAU6HSuRk8zBTyqka897bnBlxC
        lXjkAHnESUu1Seq4eX90LC6ma2CWjwiO2ShxB6nNiZeRd1z5kWmJNpPz9uD9ophnCBAfRO
        MZyvZp5pCrbANylZyZdos+6Gv1cRLN4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-XY0srifZOfKnXig1d4bYlg-1; Wed, 25 Oct 2023 05:03:12 -0400
X-MC-Unique: XY0srifZOfKnXig1d4bYlg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41cc9224395so63653481cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224591; x=1698829391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=ZOmHhc6if98mGzo7nhmyGvt+D5/AENt952MeRzKBy+GP9QeLCrTtsZFAdKZlUV7yiq
         pNWRiETjNEBXr4m1HY3sPCRRBnCHPxSNwyGPGldFVZKy8Nj81JblFWlDzzLyXnKpYf7q
         OZXfDBz2VylvAxDxiMJM8Xgh8PRyLtQAjqAh+hOFRvdJeHanQWfBZUvN8Y4rHJA0YDL/
         lcIsXEWQSsGJeZSFUO8/aUiotkvyMXSS2VVkZQk3KijV4h9KHFhwGPEA5Fu6fxNslZHO
         knlKDyUhN2Wmkq8IOZ/OHuyT5OSK4hOJTuBKebhfHLS0onP2CuSFe00Qy02lyCi9BRMD
         J5Pg==
X-Gm-Message-State: AOJu0YxQDUigQieLqYOsyHMSFveSzXLIXX5M+zlmRD2D3/DJA6o6byNH
        xR+s5qfd16BXSUtlsDfuzkcxw19l5rcAwC9ByN7vpJkEVtgLjxvtJTv21VyXpiDkCeWYcK+7XAd
        +m4o3JVOHcQecq3zmDxpY5Jbb
X-Received: by 2002:a05:622a:1305:b0:419:544d:1c0 with SMTP id v5-20020a05622a130500b00419544d01c0mr17955954qtk.3.1698224591682;
        Wed, 25 Oct 2023 02:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKOfz8sf6QMk36USoRncwKMxVog3YxhlFfRKHvCE/VcGDwXrOh6CeVi2R2TKYVAgVn3giadQ==
X-Received: by 2002:a05:622a:1305:b0:419:544d:1c0 with SMTP id v5-20020a05622a130500b00419544d01c0mr17955935qtk.3.1698224591485;
        Wed, 25 Oct 2023 02:03:11 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id h21-20020ac87455000000b00419b094537esm4083814qtr.59.2023.10.25.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:03:11 -0700 (PDT)
Date:   Wed, 25 Oct 2023 02:03:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] tpm: Move buffer handling from static inlines to
 real functions
Message-ID: <qktrbbbqrz3z4jh4h7pz42leikmyg2mdevzl2brapn32kst55e@s5thpstdtlxp>
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-2-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024011531.442587-2-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

