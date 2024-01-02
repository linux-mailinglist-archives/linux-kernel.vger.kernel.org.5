Return-Path: <linux-kernel+bounces-14715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6982182211A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1859F2841A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97CF156F6;
	Tue,  2 Jan 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b21V/35f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A1156E6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4279c2ada00so19151cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704220647; x=1704825447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Mi8qDze3+bwXuwBWgIjDpZ8DVNO9PYkwLuSaBzH6ik=;
        b=b21V/35ffoFzqpp7X8ouLCpX1+Xcn6tPqyaZPKJMDifU2Wf8wspUFFZX0aiMXT++HY
         c7BXCSFlelo8RW0OMPgkHT1zdWEBaq2Z7m27LmY80kmLWy2xOxuNRIpYk5K8VhzcXBv4
         oMFBRTeX6sIDNG2mzDywqjifaFMr6ZfA3FEmdaFo9ZtU32wsGzK3/bda3pRIaYCzewIW
         9wgr5HJCNebultGe3q8R0ks8v4Q4TeZVVSDzncN1PpBO8roeL/S9gHBEr9Koco/YNj8Q
         dhsqm+ug8Y51jrlz3SqAepvwobbTNCUKSsybgdUjDgFjR41h/yBElTaOwYWLBXYpgpT6
         hTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220647; x=1704825447;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Mi8qDze3+bwXuwBWgIjDpZ8DVNO9PYkwLuSaBzH6ik=;
        b=Cslcu18bSxygxpZCbtes/Ssien6Wro+75UVEGMDspJ1FW4IDdL0/fjCQMIqFr5Jrnq
         XgkuhAPMJ2TYor17buqdq+5gocH2iEugZ7NBzRyIF4ULriAF3Da0es86b8dpgjzsLDb+
         4pG6Fw6tcawdE2cN+HbfWvY+dhlEwTvhsgqBF+YRD7nvwT9K/u4bMv7DSEs+xklEP+sp
         whklkV+zwZjaPWn4kQ/KTTnAOl/A+LnAU7KptqHJEW83gbLxFFOHonYzMDSea8dYlU3u
         GWJB99dT/pAfNRbFnGTBjbRaLnEEzP5tbJFdfKp8QQMWBP+4sUSq4RVXzitbMXC/S3am
         S0GQ==
X-Gm-Message-State: AOJu0Yz9d2siK8sD+MaJnLwbYdqKf1Jkw9g3Ve52nySXvYnxNyeH+Ovr
	juNFfDUuykBf5FyV8xqT0JYrR1G5EojyrjvIfE4jqYuZ7X8J
X-Google-Smtp-Source: AGHT+IG/fK5+QnFBo0Hw6tcqQgKLJSbgYF08cFROI9q+Dviq2sWszrRitn/a475M3EHJ4XxiODoT460MaOnwaRT6gIM=
X-Received: by 2002:a05:622a:1113:b0:428:32a2:4997 with SMTP id
 e19-20020a05622a111300b0042832a24997mr152065qty.3.1704220646666; Tue, 02 Jan
 2024 10:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuxiao Zhang <yuxiaozhang@google.com>
Date: Tue, 2 Jan 2024 10:37:15 -0800
Message-ID: <CAOOoKeS_Xiteh0rNFGxgg-fPk5wXvgJuaMc47rp0EaEX-gJUCA@mail.gmail.com>
Subject: vmalloc search size larger than the size it is actually needed
To: akpm@linux-foundation.org, hch@infradead.org, urezki@gmail.com, 
	lstoakes@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi vmalloc experts,

Recently I found an issue when unbind/bind a driver and hit vmalloc
failure. The symptom is that the initial memory allocation can succeed
during the start up. But if later I unbind (so it frees the memory)
and bind it again (allocating the same size), it will fail. further
investigation shows that it is because that the search size is
slightly larger than the real size it is needed:

/* Adjust the search size for alignment overhead. */
        length = adjust_search_size ? size + align - 1 : size;

Assuming that the device wants to vmalloc 256M mem, What happens here
is that during the bootup, the driver bind happens quite early so that
there is plenty of free chunks in vmalloc spaces, and the largest is
far greater than 256M, so the check never failed. After the boot up,
the vmalloc is filled with other stuff, and the largetst remaining
chunk is smaller than 256M. Then I unbind the device, the used 256M
chunk is returned to the free vm tree/list. When I bind it again,
ideally it should take the previous area, but the search is checking
more than 256M (256M + align - 1) so the vmalloc failed, although the
original chunk can still fit.

Is this expected? Maybe we can add another find_vmap_lowest_match in
__alloc_vmap_area with adjust_search_size==false, if the original find
failed. Does this make sense?

Thanks,
-Yuxiao

