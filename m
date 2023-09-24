Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469987AC9CE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjIXNnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIXNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:43:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4483;
        Sun, 24 Sep 2023 06:42:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso3589363b3a.0;
        Sun, 24 Sep 2023 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695562975; x=1696167775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrFopNmjSQ+mWeZ3YOPDKDPIgq70BZiGeex/EKCnWEE=;
        b=Nx+T07OLNKfRmpuCy5q/rAW0OpMKEGj04SJUCMRoK1lm52Lj8YOFtsHibN6nPkZXIZ
         lnVrxLoCz86gJe91gGQa7NIFO0+mVnha/gtL082ArsnLHodQz8O49UuPYaU3r8OcM3IK
         akHUvp000SyN+M4gaK8pnQrkfCKwsPgxGG1NVScSTXzGPCI87jlmbwTXbQhs4TMptn+F
         vz74YvWHapZYHb7znz9ZpCpeco4PUNdhG29i2tmN9GVjDr9z+aEh5/e6qss7Lj9R0KuJ
         nrA2UdMZ7q0Qo4sje9llNTzjodMlOOfF98X35FnO7gW0PwADNlaLP5LJeU0cq3Zl0R7x
         PIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695562975; x=1696167775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrFopNmjSQ+mWeZ3YOPDKDPIgq70BZiGeex/EKCnWEE=;
        b=jCoK5MTXdbsuAnuVc6OeXO1O0ixj0bHR4e4EKrdUys6g3Kiozffj/wTh6aISFebDBD
         9RxzBJl2ttYn9RazcfOaSBh2QWg/D9eLOFHmMXuSszIJaJ8rTR+o0GtG07WK87CgjZ5U
         e6TJWfRviYnTB9B2ECOQkD0fqWbeHI6PC35BeehErP2kEEnNPmEIz+/67zUsrDiVNoic
         Y9P+veC2SPDxXBDrD4rLzypBQ6ISQrHKvHc1Zzmod0Gz3zHxIkeS/K4XKM7qphppA3BO
         /hXkWrYtwqs5hKHOGFmCIxXpH6Nd+uttydZP29be65rB3ppsQ8Iw1ixbpfRHfHfrTBtT
         lU/w==
X-Gm-Message-State: AOJu0YybHquaZvZL96AQmGHzzQMMTd80KpZsbscNcEPGfal4LQTPZxFk
        8+NHA5yStOSUOse44TLrytc=
X-Google-Smtp-Source: AGHT+IFTFONmx2+qIt3l3QdoFnCvC9IAaiNaTtSxYIDfygciCn+NvD/3U36OByjSWUCEVSaVC1G/Fw==
X-Received: by 2002:a05:6a00:39a2:b0:68f:d44c:22f8 with SMTP id fi34-20020a056a0039a200b0068fd44c22f8mr6697763pfb.1.1695562975155;
        Sun, 24 Sep 2023 06:42:55 -0700 (PDT)
Received: from localhost ([162.243.44.213])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78c1a000000b00690d5d8084dsm6375415pfd.60.2023.09.24.06.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 06:42:54 -0700 (PDT)
Date:   Sun, 24 Sep 2023 21:41:53 +0800
From:   Jianguo Bao <roidinev@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 1/2] rust: arc: rename `ArcInner` to `WithRef`
Message-ID: <abrhhfol7w6a3uovjuuqgl4l63jh4ibljpbuebiikpj7glmcfu@5ryh6f2ll2vt>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-2-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923144938.219517-2-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Jianguo Bao <roidinev@gmail.com>

