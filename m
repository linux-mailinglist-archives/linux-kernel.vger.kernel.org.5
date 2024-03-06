Return-Path: <linux-kernel+bounces-93695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20505873371
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE65F287856
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D686088C;
	Wed,  6 Mar 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gMWrhojv"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E25DF30
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719190; cv=none; b=olESMobc3qbpEcN1uJ9nZCDswbP9j1DFGU/ijJFeCmR8nFheAbxueER8A6fqTgh36uK8rf69u+e8ekb/3AtB/3bDFdS1Gyn9e+RDV99bYJn8GYXerNTmk8eyMZY4fdtTIKGtLjSWYJZsbbKcr4JkYUU+8wBLu+KUXAMx3g3DCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719190; c=relaxed/simple;
	bh=PYrLa71JafYTrx6ScD/co5t0rYc+KGdAr2yCFd2nTeI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6XQCPfAABmLcc7quuHpC/YWE2XL49HsiGS9m9krpUWLBxIKVK296yHoRHSXz3C0HuYxlZb9guffERKv/u8iBjgA0ND4dy7fgXwScbjQHKayjOHD5UAcTGbX1cwbkGOL6hHvwBurGrKZrGS18wf2AFP+Edpv/ubLAxL8mglSFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gMWrhojv; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709718879;
	bh=oNIsFqxxtkHbwol+QQzHwWGVGalIcSBK9gQ9PgE3tlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gMWrhojvFUpZkWNcj5+4X2MOJXXyg/J2T+JkpJzocWn/jdURgbiQ9F3RlpteXW7RZ
	 l6wn5kioiVwI+aasY2NfW8BvcePMcc3hOq2DSFDr+OOtZYhlXbgbzcyHfLJuR/ffZQ
	 hi6gx+/jlDvfjSIiijDH0nnUm+TrCyOvC4lDIkUE=
Received: from localhost ([2409:895a:3aa0:aa0:3ef0:ad11:601:8a38])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id DA515AD4; Wed, 06 Mar 2024 17:54:37 +0800
X-QQ-mid: xmsmtpt1709718877tmkxjqfu6
Message-ID: <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
X-QQ-XMAILINFO: N3QMWHy44bBnzVjCFnVL/EJKR287sqNOnb7s3DASL0C7TUlF8Mwqub5ZvAESTp
	 9Lz+7mtA3/FQK/x7U2OKgM8bLI4FEg6lEkBcvZhembgq1sCsLuM2nxyqxvq+cDvuERHArRuYYm+J
	 +oV5CQzgZUgo+kaOhLQ8T83MgqrZB+zkyBslhfwzNpZXvO01yO9FIntCsVjGF4qJdFtOBVN8TekQ
	 Jmyjjrh6YlvRK3MqDsTuSp3+54ZOyZ/9mqkT35Q/sOcdJSMiaDmkBdUPXwBfFXAJ02eaERoy4nuv
	 os06Qh7YrdFjmJ/Wz/nEBDwga3k1I/hTWE76nu5xOKOEyEgNrPZKxhuVH066kT0nMepcMGt6+htF
	 IyBJBK8oi21RKGRB4qNG1iugxMXCmUA1xoJcDa99rSAVtFYr7ZTtA9vfLPuICuwuvk5fmwOY9LrH
	 TZtgClDeSelwcyRn0i2nSaqffpNJLPS+3lPM6p38PrYt+wtBftD0SvnyR3X/XU4gIutLu44+BLgZ
	 iTu9Ulqt8BuXFBNWn1A1p3/zd33ReKYe/prGpzqKpiOzTiQJqntCiyVd9RvPf86uNErt7rWCo8ug
	 X68pDK+ou3F51hXFDBdL/dRSDK4HaHOXv1e2g7b45btbOSqHFTL3db9OnQCWiVKUosQGW0oQ5MyI
	 jh0/CxjPsQEHtwW0FrGduq28CWMSTcsV4Qh1JS4d1HDqwGbMN2WCoQaP3tLeygyfsg3LChJy84xH
	 2EfUTBJuMVy5vHKzZGGB2SkZKGp2VoghKcoeDkSdHgxqlyl1IXohYNCbReMBXoFtvMsBjoq1CyBT
	 D41uA5SL9DtJzz8xwYnXvKOSuVkvZTgVqK0y2KkK6+kwhXJSfsQa9JGearyD2A9CEpgG5gtKuf8l
	 qQ5U9t6Pug0ZYXki9+u8Fv03V1lFCLQfczHvwEb21PpfzBI5duVa0DVYysQHgDN/iWDCWdD0XPbd
	 a0q1RBElSz2Vzd23Yv56NMTmKT//R7ue0EQERoi0w=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Sender: kenneth-lee-2012@foxmail.com
Date: Wed, 6 Mar 2024 17:53:31 +0800
From: Kenneth-Lee-2012@foxmail.com
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
X-OQ-MSGID: <20240306095331.sgmksoorkebfb2cw@kllt01>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zedd18wiAkK68Lzr@andrea>

On Tue, Mar 05, 2024 at 07:00:55PM +0100, Andrea Parri wrote:
> Date: Tue, 5 Mar 2024 19:00:55 +0100
> From: Andrea Parri <parri.andrea@gmail.com>
> To: Kenneth-Lee-2012@foxmail.com
> Cc: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
>  paulmck@kernel.org
> Subject: Re: Question about PB rule of LKMM
> 
> (Expanding Cc:,)
> 
> > In the LKMM document, it said the pb link:
> > 
> >    E ->coe W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F
> > 
> > can make sure E execute before F. But the cat file define pb as follow:
> > 
> >   let pb = prop ; strong-fence ; hb* ; [Marked]
> >   acyclic pb as propagation
> > 
> > So the acyclic rule is only on pb relationshit itself. So it won't
> > forbid F -rfe-> E, will it? It only forgit F -pb-> E. So how can
> > propagation rule ensure E execute before F?
> 
> With regard to your first question, the propagation rule does indeed forbid
> F ->rfe E.  To see why, suppose that F ->rfe E (in particular, E is a load
> and the first link in your sequence is fre instead of coe).  Then
> 
>    E ->fre W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F ->rfe E.
> 
> Since any rfe-link is an hb-link (by definition of the hb-relation), the
> previous expression can be written as follows:
> 
>    E ->fre W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F ->hb E,
> 
> that is, given that hb* is the reflexive transitive closure of hb,
> 
>    E ->fre W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* E,
> 
> contradicting the fact that pb is acyclic.  An argument similar to the one
> reported above can show that the propagation rule forbids F ->hb E.
> 

Wow, my gosh, I didn't expect the last "hb*" works like this:). Very clear
explaination, thank you very much.

> To address the second question, I'd start by first remarking that the CAT
> file doesn't define an "execute-before" relation currently.  This file does
> however include the following comment:
> 
> (*
>  * The happens-before, propagation, and rcu constraints are all
>  * expressions of temporal ordering.  They could be replaced by
>  * a single constraint on an "executes-before" relation, xb:
>  *
>  * let xb = hb | pb | rb
>  * acyclic xb as executes-before
>  *)
> 
> In this sense, the propagation rule (like other "acyclicity"-constraints of
> the LKMM) expresses "temporal ordering", and any pb-link is (by definition)
> an "execute-before"-link.  The file explanation.txt can provide additional
> context/information, based on the (informal) operational model described in
> that file, about this matter.

So it is just a rule in the sence of mathematics? I think it would be better
if there were some explaination in the explaination file. It is
descripted in nature language, the reader might not notify it is just a
mathematics rule. And you cannot say an action executes before another
because they are in the pb link. It becomes a cycling in logic...

But anyway, now I understand. Thank you very much.

> 
> Notice that, as examples in tools/memory-model/litmus-tests/ can illustrate,
> none of the three components of the xb-relation is redundant.  Specifically,
> there do exist pb-links/cycles which are not hb-link/cycles (and viceversa).
> 
> Maintaining three distinct/separate constraints (happens-before, propagation,
> and rcu) instead of a single "executes-before" constraint, although formally
> unnecessary, highlights the modularity and eases the debugging of the LKMM.

-- 
			-Kenneth Lee


