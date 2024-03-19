Return-Path: <linux-kernel+bounces-107958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE988041C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7578DB2314B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16697282F1;
	Tue, 19 Mar 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUIVV/qi"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBF23772;
	Tue, 19 Mar 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871173; cv=none; b=XPBu+9l34rycGohF9UJoHUL5JM/NL0tXzBJfLysCuu+BJPaNrMUeaOuUEZ7F3I1Gv9D6wS/8wwe+r1122y7yaE4GeysYLLgOfzQLaO2k48EgHtnx7Zmnu9XGBdzkfu6QKFOw6XrKhaVwgaa+MlCWDrXY97J03AOOx6lxpV3UBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871173; c=relaxed/simple;
	bh=CStYVCbwa3SM09u8mdWsii9+sW18CUi2oA9JWjwq60I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tn2ijbSuyZ3fEpptQ8ZW87gn1916S0P6ezpDiKZaVHEH7e0QGA9EZHMVkLGHy9yzD3FtpiEN5zHPq+gNpxuQeGIrSkIsgc/It/AXNOZ0EN6IflwOUZhUwzBm0/IocV/NadtB/n0f+m/iTcM7JE0Ok81xnT+xLd5gJvpeZCJz++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUIVV/qi; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dc8b280155so3749894a34.0;
        Tue, 19 Mar 2024 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710871171; x=1711475971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUviNEGEqF0+oL+GaKig6+TM+nN7wBAl9E2p2JkHJnc=;
        b=HUIVV/qia2xbYtLa3Z6JwHhZo5QFlw8r2m0B30ltLbZ9WrccfI1xqymmd2SEqYPYcx
         mP4GJVqtCIcThsdm+GVL313k/PvlaFTnS93bYwP0NdkY5WTRRUrMxKNoC08fcsba37Sv
         00voRVE6+Uz7WDdOLoSfR4nUOlrgUk0amAxWnbcmv0IQM9Ulst3V838NtjbnabG0TWql
         GhNizf/PepVErk/Qo1a/qNCE54+O9aMw9x0xy3ReL/F4hE+NYy8G3cVZn0PYh0u2Vo7q
         tROn/v4GGjVy3SuKSiZQLDbpgNe+Ki18cffSnToeBdyDEB1fNBUOLV9QvRzww/XuDpdS
         3MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871171; x=1711475971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUviNEGEqF0+oL+GaKig6+TM+nN7wBAl9E2p2JkHJnc=;
        b=VC0Un3LE0dJLeSgxDOcGhmnCQgJw3yHJ6TDTUixZbKXb7MRoEIQp2x40w77QSFhWWh
         pj0pu6y1bV95P4/l1qXtvPK6BnLc0h9n7zlztSgjES5+GFXzDytda/PkqlTzFjMungiX
         ymBqx8ZH7gp1RqbDB0qKupVLSwbxEcH2kKMsk/toeJ/SQylo15STMHKJbKJ4F28BQklW
         7u/4ZpPKE66so39XPm/+mUXyYFlNiliFxV5pgO304W6NQ428olkfJTLPSFEo3BxEiUlP
         8Rf84x1VDj98mjjNszTjTT5JpsXFuRMvrozRG/PpT3U9OaVldn/LDjJP+Y94L35B+q2w
         dEvA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Qb9p8CQRKfk/digwioltrw1TW3tZQE8MMJThr/UaEylxWoIAI8fyggTjgyo9TzVSxOvwhnN1CL/I1lsCvRxHGW0lLE3KKtES2u0peIa3i1xP48ZwSRmYKb0SO2I5YWwJSo6yaeL7
X-Gm-Message-State: AOJu0Ywx6Cc9R9xaYeoPJV7hSaz0rDA1ifB12ZZCsEjSq5IVcm5XrpnR
	LlPMiI7IICrlW3ULf8+73zRGQIDAbvf1kiVHgmE2N48oCmNWYJ9+gEpFNlHLPU6Nn173ISqSGM0
	ttTUykHyWGbdkg2iEr35jp/wRENc=
X-Google-Smtp-Source: AGHT+IE+RutNEX3M+HIkQNfNpI+FwvPVtCZ/xwoKMyDLGVXTUIL9sN4LxDcYmpdBxbiguwrC/QknDAQHtY/D1IrFkj0=
X-Received: by 2002:a05:6870:b529:b0:221:a08b:5fd7 with SMTP id
 v41-20020a056870b52900b00221a08b5fd7mr14676195oap.59.1710871170790; Tue, 19
 Mar 2024 10:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301141800.30218-1-lukas.bulwahn@gmail.com>
 <m21q8732wo.fsf@gmail.com> <41f28393-0211-4448-8add-ad3c55d02210@oracle.com> <CAD4GDZzjc6=-Gzw23tRgCDE7=AxsenXqpD+qnh6gj1+MYYU2fA@mail.gmail.com>
In-Reply-To: <CAD4GDZzjc6=-Gzw23tRgCDE7=AxsenXqpD+qnh6gj1+MYYU2fA@mail.gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 19 Mar 2024 17:59:19 +0000
Message-ID: <CAD4GDZyABi3wjKY4SUV804OyBDBaC=Ckz5b0GZ34JmCX8S6V_g@mail.gmail.com>
Subject: Re: [PATCH v2] docs: drop the version constraints for sphinx and dependencies
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 17:10, Donald Hunter <donald.hunter@gmail.com> wrote:
>
> On Mon, 18 Mar 2024 at 16:54, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> >
> > > % time make htmldocs
> > > ...
> > > real  9m0.533s
> > > user  15m38.397s
> > > sys   1m0.907s
> >
> > Was this running 'make cleandocs' (or otherwise removing the output
> > directory) in between? Sphinx is known to be slower if you already have
>
> Yes, times were after 'make cleandocs'.
>
> > an output directory with existing-but-obsolete data, I believe this is
> > the case even when switching from one Sphinx version to another. Akira
> > also wrote about the 7.x performance:
> >
> > https://lore.kernel.org/linux-doc/6e4b66fe-dbb3-4149-ac7e-8ae333d6fc9d@gmail.com/
>
> Having looked at the Sphinx code, it doesn't surprise me that
> incremental builds can have worse performance. There's probably going
> to be some speedups to be found when we go looking for them.

Following up on this, Symbol.clear_doc(docname) does a linear walk of
symbols which impacts incremental builds. The implementation of
clear_doc() looks broken in other ways which I think would further
worsen the incremental build performance.

Incremental builds also seem to do far more work than I'd expect. A
single modified .rst file is quick to build but a handful of modified
rst files seems to trigger a far larger rebuild. That would be worth
investigating too.

> > > I have an experimental fix that uses a dict for lookups. With the fix, I
> > > consistently get times in the sub 5 minute range:
> >
> > Fantastic!

I pushed my performance changes to GitHub if you want to try them out:

https://github.com/donaldh/sphinx/tree/c-domain-speedup

I noticed that write performance (the second phase of sphinx-build) is
quite slow and doesn't really benefit from multi processing with -j
nn. It turns out that the bulk of the write work is done in the main
process and only the eventual writing is farmed out to forked
processes. I experimented with pushing more work out to the forked
processes (diff below) and it gives a significant speedup at the cost
of breaking index generation. It might be a  viable enhancement if
indexing can be fixed thru persisting the indices from the
sub-processes and merging them in the main process.

With the below patch, this is the build time I get:

% time make htmldocs SPHINXOPTS=-j12
..
real 1m58.988s
user 9m57.817s
sys 0m49.411s

Note that I get better performance with -j12 than -jauto which auto
detects 24 cores.

diff --git a/sphinx/builders/__init__.py b/sphinx/builders/__init__.py
index 6afb5d4cc44d..6b203799390e 100644
--- a/sphinx/builders/__init__.py
+++ b/sphinx/builders/__init__.py
@@ -581,9 +581,11 @@ class Builder:
                 self.write_doc(docname, doctree)

     def _write_parallel(self, docnames: Sequence[str], nproc: int) -> None:
-        def write_process(docs: list[tuple[str, nodes.document]]) -> None:
+        def write_process(docs: list[str]) -> None:
             self.app.phase = BuildPhase.WRITING
-            for docname, doctree in docs:
+            for docname in docs:
+                doctree = self.env.get_and_resolve_doctree(docname, self)
+                self.write_doc_serialized(docname, doctree)
                 self.write_doc(docname, doctree)

         # warm up caches/compile templates using the first document
@@ -596,6 +598,7 @@ class Builder:

         tasks = ParallelTasks(nproc)
         chunks = make_chunks(docnames, nproc)
+        logger.info(f"_write_parallel: {len(chunks)} chunks")

         # create a status_iterator to step progressbar after writing a document
         # (see: ``on_chunk_done()`` function)
@@ -607,12 +610,7 @@ class Builder:

         self.app.phase = BuildPhase.RESOLVING
         for chunk in chunks:
-            arg = []
-            for docname in chunk:
-                doctree = self.env.get_and_resolve_doctree(docname, self)
-                self.write_doc_serialized(docname, doctree)
-                arg.append((docname, doctree))
-            tasks.add_task(write_process, arg, on_chunk_done)
+            tasks.add_task(write_process, chunk, on_chunk_done)

         # make sure all threads have finished
         tasks.join()

