Return-Path: <linux-kernel+bounces-92800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D887261D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9978EB25394
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F3A17C60;
	Tue,  5 Mar 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIEjZitG"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563E17BAF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661663; cv=none; b=nAiXEgdrIBmWTw7SH+QjtU0ayZRgSh9EpMFVdx9HIUTseKbSZGpPeWOuJtPKHP49Oxbkx1sylzOWXzIpnnkKlrpXJJ7LkM3DXAULppztEOdCq/ecHrFU6I+Dg8FiGfrC0TAINuVCEvEV2udVPOCWJr3AVd6nh2SIT97sw/rlMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661663; c=relaxed/simple;
	bh=rEM1Wot+0yLrpjry9XjrxZc/2orBsoOXWjzQ3b1DJu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCWCWQpquEsF1kGme/WbaxbrLUus0srBU+P31SqNCqrZtCQRfSjxtFrcx0QqgoRKGBhR9dO55t32vXw1ySx7Ff7vM8qI71Q3R3UiuHKtL5qOEbx2we9w4MXR92Odj1zhxNJKgWvU0wc9reA6YGWBBVgpeOgzVjz3dl0gq5rweG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIEjZitG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so76015661fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709661660; x=1710266460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27cpkDliv4phKeyXY6if7yaIXftfTDK3iYfOFdeql1g=;
        b=NIEjZitG6kXmbvtbAmoZiLOYQBEWQOPxSguAgcgXJo4fUEnqN/np8uk7zZAGljJSd+
         mYCprHlY1ltJ6nZf7DmJt9YR+jqztoHX3VCKdsNtKelCbxLHe1x9x8XcaigLbSWxUSys
         K3BDkb3R3vdclM1Clke3x+WieqxYgBX0/TrvuPHFPWoaw8heupc9Kzm5V1dEYsUfz4dK
         eaFNnHL6QgA5+iwkfe9yzJmXeUUItC5wA8dCPRNrEaUdGltpGbS7KY4HJ/6FzoCsUlVu
         2XIQiMyxCgLMcOoWO+uOKZim/0wCUp6jNVEkbhi+RYOCk5wmXPsfMpmFxAq/mtn1Lev4
         rcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709661660; x=1710266460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27cpkDliv4phKeyXY6if7yaIXftfTDK3iYfOFdeql1g=;
        b=sRatKNHLorr3Mdl3Es9OfapbCW8WnEnBKSkR7Ablhti5/cVLt9zEnbNuWcdSfll01C
         1YxESUqlvBGdUkIaLwRTilQTZ8htcxMLZs4zxWRGQf+Fu5QVXxfj+CgS8f+lbTTRa9nE
         L0Pj59OcsHlO6OkCaJY53gAo626X+ILjEpvdrincWz6HVscgSAh6i0fuKhes5jjLvXWg
         OHgL8J5nG2YVKGBt9MlngBOzASVJyjOsDU7HZFUX3DuA78624gFcbrcCMB0peA1KZWFM
         6wlHSmd+J5XqmM64LRBShFLDgcgYb4vpSzWYx+dvRARLet8AlTgRt8Z712GWaanBfIFz
         sJAg==
X-Gm-Message-State: AOJu0Yyncj9u2rtDEgCrFR10xj7ZWnnqImXp2w74VJIhVGb6JA/s4sRn
	/ne9jxiHZhHpDHQZT+a5WIVuoKBDSM9DzahptZ0QoZ17mC3tLA9R+/OCnX/N
X-Google-Smtp-Source: AGHT+IFKX8+8URYxyxUJsgoJ+Oz4/wcLoiLbqa3zby1DTxGgL2hXp2Rdz1Ms4h+z71AoiU5kh0HBbw==
X-Received: by 2002:a2e:8e21:0:b0:2d2:c1dd:4877 with SMTP id r1-20020a2e8e21000000b002d2c1dd4877mr1543116ljk.32.1709661659472;
        Tue, 05 Mar 2024 10:00:59 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id c28-20020a50d65c000000b00565a9c11987sm6292454edj.76.2024.03.05.10.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:00:59 -0800 (PST)
Date: Tue, 5 Mar 2024 19:00:55 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Kenneth-Lee-2012@foxmail.com
Cc: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <Zedd18wiAkK68Lzr@andrea>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>

(Expanding Cc:,)

> In the LKMM document, it said the pb link:
> 
>    E ->coe W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F
> 
> can make sure E execute before F. But the cat file define pb as follow:
> 
>   let pb = prop ; strong-fence ; hb* ; [Marked]
>   acyclic pb as propagation
> 
> So the acyclic rule is only on pb relationshit itself. So it won't
> forbid F -rfe-> E, will it? It only forgit F -pb-> E. So how can
> propagation rule ensure E execute before F?

With regard to your first question, the propagation rule does indeed forbid
F ->rfe E.  To see why, suppose that F ->rfe E (in particular, E is a load
and the first link in your sequence is fre instead of coe).  Then

   E ->fre W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F ->rfe E.

Since any rfe-link is an hb-link (by definition of the hb-relation), the
previous expression can be written as follows:

   E ->fre W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F ->hb E,

that is, given that hb* is the reflexive transitive closure of hb,

   E ->fre W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* E,

contradicting the fact that pb is acyclic.  An argument similar to the one
reported above can show that the propagation rule forbids F ->hb E.

To address the second question, I'd start by first remarking that the CAT
file doesn't define an "execute-before" relation currently.  This file does
however include the following comment:

(*
 * The happens-before, propagation, and rcu constraints are all
 * expressions of temporal ordering.  They could be replaced by
 * a single constraint on an "executes-before" relation, xb:
 *
 * let xb = hb | pb | rb
 * acyclic xb as executes-before
 *)

In this sense, the propagation rule (like other "acyclicity"-constraints of
the LKMM) expresses "temporal ordering", and any pb-link is (by definition)
an "execute-before"-link.  The file explanation.txt can provide additional
context/information, based on the (informal) operational model described in
that file, about this matter.

Notice that, as examples in tools/memory-model/litmus-tests/ can illustrate,
none of the three components of the xb-relation is redundant.  Specifically,
there do exist pb-links/cycles which are not hb-link/cycles (and viceversa).

Maintaining three distinct/separate constraints (happens-before, propagation,
and rcu) instead of a single "executes-before" constraint, although formally
unnecessary, highlights the modularity and eases the debugging of the LKMM.

