Return-Path: <linux-kernel+bounces-46547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03827844130
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CA01F274C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2ED81AA5;
	Wed, 31 Jan 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwA9Q0ik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DFB80BFD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709537; cv=none; b=Ubwh0Lylr078gffkRrNygWoEa0rmnBSsqhkskHqSy7BnPn/dDcf0wYhqlDc/mfQIaGEyYNztW5jlL5AobuaDzfIKCcYDy6xBxO4kf/B6k8iJPpGSny+IZ+SxX9Sgknxn/dLKvR5WfAzJxKdNcAd6N9AhpUfusctccRPlpZRQ/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709537; c=relaxed/simple;
	bh=nTzlQ/FNZhR5IkDOQ6Tuz0YJwtUD84KZOqRKzrWu48I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7+hZCPv6i05QwYQnHYLBWeu2zLSsdbAUY4yegnRaikVd6D/pZrbv/z9T3RkHjXtRzURMUJ0jHMHOdJBrL8drcQIp2npuyp3DRgcOZlxNI+5dKByoUT3SnXnoGYFl11y43J2tmYtiphbOma4VEndq/dMlXM86u5z4K4GYshxt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwA9Q0ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA74EC433A6;
	Wed, 31 Jan 2024 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706709537;
	bh=nTzlQ/FNZhR5IkDOQ6Tuz0YJwtUD84KZOqRKzrWu48I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwA9Q0ikGnQYaUrRB7Ucdxw7bz2jciqFRp/J0q4DMH7cGxsLJr/SDzGA7ZYx7TJG3
	 QcJ/C2F5ilr6lBAZZ0IKiKVeWoTI2Z254d8ATujQKwvZpHoOk+6RJMAXSA301p4PIM
	 DG6op5ClZfnYvxOtHwDdlkYTRobry2YKviIbQSrq52NJmMwnhh4I9jN9PyfyNzKQUl
	 RywwfBuKyp0gBpt4dVmXE/a/dEcaNelqWcELgYqN7a1DyOJJ38mmYuxEFZQQ9TM/jM
	 qsbivuTri9LAGU2V1bqL8HV0Ut/6ulvelbJAFhUj6/1uAskOkRMHN2+YmenvzpIgpR
	 c4i6LqlfRCAbA==
Date: Wed, 31 Jan 2024 14:58:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240131-knifflig-bestrafen-d7e53ebfc291@brauner>
References: <20240131132541.GA23632@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131132541.GA23632@redhat.com>

On Wed, Jan 31, 2024 at 02:25:41PM +0100, Oleg Nesterov wrote:
> Please see the interdiff below.
> 
> Also, I updated the changelog to document that the behaviour of
> pidfd_poll(PIDFD_THREAD, pid-of-group-leader) is not well defined
> if a sub-thread execs.
> 
> Do you agree with this semantics?

Yeah, that seems fine to me.

