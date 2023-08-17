Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468B77FCEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353928AbjHQRWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353932AbjHQRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:22:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C499EE;
        Thu, 17 Aug 2023 10:22:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso1244365e9.0;
        Thu, 17 Aug 2023 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692292949; x=1692897749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxMhizufldjXqr2LJXmRW1fhXbnI6OJa+DaLU10aqqs=;
        b=cE8nmPU79jz365GDzNZwMeC+RHo/75g3Hck2wL6uFmYOTaBzRFKml9H5vGH5fEcJBc
         jYTJ4sk/kjrf+b4Z+MaLyZrEO+82tJty+a3J07Pz7mjVe+3ffew8c0W5xJspajTcpipa
         g4IUjaDodsrhE8aX4DE0+D22u8k36Gl8IzD6FhhVQc5NEB4pAt2TTNWxqaQO/cms6r5G
         BzsQWy5oogh9cAR3lGOrk5wHE2iFjqCNxOsaz+MHnupl6aQ3KPP8XH6U/rJcAM9owbTf
         jJd4l4LnWgN32zKjceKvj/j1Q94MdtKYcefG8JWWNunae8yUOO47sr2eBCSEB37gu6Zf
         5BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292949; x=1692897749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxMhizufldjXqr2LJXmRW1fhXbnI6OJa+DaLU10aqqs=;
        b=bahiDXN/gSm/HRMHNI8tN61R4/HoTwOUXsDq2r6pI96rqzHHPdaag/hyoBJq9tJzMy
         tsgvOLsY/0RAHqkuHM5GK2rPcaZlyw4iJmHxVbS9SvQY4gqXlUa+Sx1NufRVBIxSasze
         whjQdUOcE71Dl3DZ+b5bTWZ7IqzAwvtYgNyP2FRvEWyFOP3zBnv94aZ1nrdGk0ULbIgO
         g01cGGjAzFYsbIdPGFLIAvf5dOIzSNDZ6sJlwOXIu8IN1nu3zO2qEY2CpCpjafEZx/PU
         AnuqjnPuFUqKvve4AHhbCLV3OKFSjd1eD5IJAfIj8aE7P8+RbkMjQcQ13V8KlC3tBbV9
         +0sQ==
X-Gm-Message-State: AOJu0YxzPgN2wFhgejy22JebuYhPF+K2eZlGyrTPKOjDVaekfqPtnG3h
        UAeqq+PpOGjN8qAyE6FNvsFvgqFtksw=
X-Google-Smtp-Source: AGHT+IHUcsncBbdMEjkERvYbkzbI5x/ECjIiPMT2fuyKCWabM0+Ufwa1Gdq7bs5fdXXcSgHEV3JrAQ==
X-Received: by 2002:a7b:c84b:0:b0:3fc:616:b0db with SMTP id c11-20020a7bc84b000000b003fc0616b0dbmr327435wml.9.1692292949050;
        Thu, 17 Aug 2023 10:22:29 -0700 (PDT)
Received: from suse.localnet (host-79-56-101-183.retail.telecomitalia.it. [79.56.101.183])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c0b4900b003fbd9e390e1sm3629554wmr.47.2023.08.17.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:22:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Deming Wang <wangdeming@inspur.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3] Documentation/highmem: Add information about
 kmap_local_folio()
Date:   Thu, 17 Aug 2023 19:22:25 +0200
Message-ID: <2898756.e9J7NaK4W3@suse>
In-Reply-To: <87r0paxooq.fsf@meer.lwn.net>
References: <20230708121719.8270-1-fmdefrancesco@gmail.com> <87r0paxooq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 14 luglio 2023 21:45:09 CEST Jonathan Corbet wrote:
> "Fabio M. De Francesco" <fmdefrancesco@gmail.com> writes:
> > The differences between kmap_local_page() and kmap_local_folio() consist
> > only in the first taking a pointer to a page and the second taking two
> > arguments, a pointer to a folio and the byte offset within the folio wh=
ich
> > identifies the page.
> >=20
> > The two API's can be explained at the same time in the "Temporary Virtu=
al
> > Mappings" section of the Highmem's documentation.
> >=20
> > Add information about kmap_local_folio() in the same subsection that
> > explains kmap_local_page().
> >
>
[snip]
>=20
> Applied, thanks.
>=20
> jon

Jonathan,

Can you please tell me which release is this patch for? I see that it has n=
ot=20
yet reached upstream.

Thanks,

=46abio




