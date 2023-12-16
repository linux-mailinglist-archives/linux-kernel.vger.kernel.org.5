Return-Path: <linux-kernel+bounces-2097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578458157D3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF5B1C2496C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E814A91;
	Sat, 16 Dec 2023 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsUUFNTT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B41427B;
	Sat, 16 Dec 2023 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d04c097e34so10095385ad.0;
        Fri, 15 Dec 2023 21:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702705263; x=1703310063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuYeIIf0p718T7h5Nm2UzNsdfXhCWcwwG6xrxvFIOTg=;
        b=NsUUFNTTzyGYhHKsfO3wTFp1X7tfb9RrVupk2N+hmqD04Fq+FogoTG6LGVlvuYscba
         lw3UzvhvusakGgo9NxTN+EJyiYhYJT5d3QVQS4CB6dneSsxGGXLXNglCW/cvm6O1Gnn3
         Q+/3X3rdr+muyTnJeKRMvaYb09eI6f4/FOw+E06Jfm7VR1LQwrpO7HKIlXBxhDsP5gk4
         JoSylFrDEdrPJqYPYjv7DQV4ParCMcsSkVVdSfaCPSOQV5TVRwnt31fBb1gqgexYiwMK
         lyVBOHNDk05+yw4jftjdykVnPj8PIbjV1tgXZMmipcO6F/28Zzj9SYYO0hd3x7nfYoSP
         1fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702705263; x=1703310063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuYeIIf0p718T7h5Nm2UzNsdfXhCWcwwG6xrxvFIOTg=;
        b=cr1SgpwuO7ZNtHLWTyF0JejMarXc1ldonax9rmQYxpHwmcSyIVZiocBDpU/npc61l2
         LBOgMEXn/F/wYy14zNB7boLDhO0RZcFCeESIjzXIrQHj1vboWlcVyUEP7GTnQQ8rCQkF
         o5NyzzD0OI2+wiSFPG2sHIyNvxQuAIVC9oFDXqoW6cdy64Or5mz2Eh0vi+3NZ/eRe0pG
         tm9TVp/P5fvJmYpXwi8QVxNFsQqUTt/owcrRpm+QETsOfsCDc12bzffYavY4KmZT2o4k
         bWIgRZV1XgLhFFJB44Lt8FonbkNmJqRCvkF6OXC7vBbugvgg/HThJta6sZqF4H6CeLXH
         w1oA==
X-Gm-Message-State: AOJu0YyyNiqwDVR2SvvBfwHYwxa9HyGuvibmub/6gPY6a+0LjROnoYSU
	g3WQPsSz1lRmfNrWXc1HoMuFB6cFaCzXdA==
X-Google-Smtp-Source: AGHT+IEk4kvlS/D/vxlaWKNGPQgkbyWp8bbxdUBHrdeEM6lycuchbF/FOzEtMxaGt00tRl9Cp6XkCQ==
X-Received: by 2002:a17:902:db0d:b0:1cf:de3e:e4ca with SMTP id m13-20020a170902db0d00b001cfde3ee4camr16878786plx.20.1702705263139;
        Fri, 15 Dec 2023 21:41:03 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b001b7cbc5871csm15165964pld.53.2023.12.15.21.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 21:41:02 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A9611102725B6; Sat, 16 Dec 2023 12:40:50 +0700 (WIB)
Date: Sat, 16 Dec 2023 12:40:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Linux RPC <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH] hwspinlock/core: fix kernel-doc warnings
Message-ID: <ZX04Ymz_vDFEeUDX@archie.me>
References: <20231206055439.671-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mOVbuljTfi3zP5NN"
Content-Disposition: inline
In-Reply-To: <20231206055439.671-1-rdunlap@infradead.org>


--mOVbuljTfi3zP5NN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 09:54:39PM -0800, Randy Dunlap wrote:
> diff -- a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspi=
nlock_core.c
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -84,8 +84,9 @@ static DEFINE_MUTEX(hwspinlock_tree_lock
>   * should decide between spin_trylock, spin_trylock_irq and
>   * spin_trylock_irqsave.
>   *
> - * Returns 0 if we successfully locked the hwspinlock or -EBUSY if
> + * Returns: %0 if we successfully locked the hwspinlock or -EBUSY if
>   * the hwspinlock was already taken.
> + *
>   * This function will never sleep.
>   */
>  int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long =
*flags)
> @@ -171,7 +172,7 @@ EXPORT_SYMBOL_GPL(__hwspin_trylock);
>  /**
>   * __hwspin_lock_timeout() - lock an hwspinlock with timeout limit
>   * @hwlock: the hwspinlock to be locked
> - * @timeout: timeout value in msecs
> + * @to: timeout value in msecs
>   * @mode: mode which controls whether local interrupts are disabled or n=
ot
>   * @flags: a pointer to where the caller's interrupt state will be saved=
 at (if
>   *         requested)
> @@ -199,9 +200,11 @@ EXPORT_SYMBOL_GPL(__hwspin_trylock);
>   * to choose the appropriate @mode of operation, exactly the same way us=
ers
>   * should decide between spin_lock, spin_lock_irq and spin_lock_irqsave.
>   *
> - * Returns 0 when the @hwlock was successfully taken, and an appropriate
> + * Returns: %0 when the @hwlock was successfully taken, and an appropria=
te
>   * error code otherwise (most notably -ETIMEDOUT if the @hwlock is still
> - * busy after @timeout msecs). The function will never sleep.
> + * busy after @timeout msecs).
> + *
> + * The function will never sleep.
>   */
>  int __hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int to,
>  					int mode, unsigned long *flags)
> @@ -304,13 +307,12 @@ EXPORT_SYMBOL_GPL(__hwspin_unlock);
> =20
>  /**
>   * of_hwspin_lock_simple_xlate - translate hwlock_spec to return a lock =
id
> - * @bank: the hwspinlock device bank
>   * @hwlock_spec: hwlock specifier as found in the device tree
>   *
>   * This is a simple translation function, suitable for hwspinlock platfo=
rm
>   * drivers that only has a lock specifier length of 1.
>   *
> - * Returns a relative index of the lock within a specified bank on succe=
ss,
> + * Returns: a relative index of the lock within a specified bank on succ=
ess,
>   * or -EINVAL on invalid specifier cell count.
>   */
>  static inline int
> @@ -332,9 +334,10 @@ of_hwspin_lock_simple_xlate(const struct
>   * hwspinlock device, so that it can be requested using the normal
>   * hwspin_lock_request_specific() API.
>   *
> - * Returns the global lock id number on success, -EPROBE_DEFER if the hw=
spinlock
> - * device is not yet registered, -EINVAL on invalid args specifier value=
 or an
> - * appropriate error as returned from the OF parsing of the DT client no=
de.
> + * Returns: the global lock id number on success, -EPROBE_DEFER if the
> + * hwspinlock device is not yet registered, -EINVAL on invalid args
> + * specifier value or an appropriate error as returned from the OF parsi=
ng
> + * of the DT client node.
>   */
>  int of_hwspin_lock_get_id(struct device_node *np, int index)
>  {
> @@ -399,9 +402,10 @@ EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id)
>   * the hwspinlock device, so that it can be requested using the normal
>   * hwspin_lock_request_specific() API.
>   *
> - * Returns the global lock id number on success, -EPROBE_DEFER if the hw=
spinlock
> - * device is not yet registered, -EINVAL on invalid args specifier value=
 or an
> - * appropriate error as returned from the OF parsing of the DT client no=
de.
> + * Returns: the global lock id number on success, -EPROBE_DEFER if the
> + * hwspinlock device is not yet registered, -EINVAL on invalid args
> + * specifier value or an appropriate error as returned from the OF parsi=
ng
> + * of the DT client node.
>   */
>  int of_hwspin_lock_get_id_byname(struct device_node *np, const char *nam=
e)
>  {
> @@ -481,7 +485,7 @@ out:
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns 0 on success, or an appropriate error code on failure
> + * Returns: %0 on success, or an appropriate error code on failure
>   */
>  int hwspin_lock_register(struct hwspinlock_device *bank, struct device *=
dev,
>  		const struct hwspinlock_ops *ops, int base_id, int num_locks)
> @@ -529,7 +533,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_register);
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns 0 on success, or an appropriate error code on failure
> + * Returns: %0 on success, or an appropriate error code on failure
>   */
>  int hwspin_lock_unregister(struct hwspinlock_device *bank)
>  {
> @@ -578,7 +582,7 @@ static int devm_hwspin_lock_device_match
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns 0 on success, or an appropriate error code on failure
> + * Returns: %0 on success, or an appropriate error code on failure
>   */
>  int devm_hwspin_lock_unregister(struct device *dev,
>  				struct hwspinlock_device *bank)
> @@ -607,7 +611,7 @@ EXPORT_SYMBOL_GPL(devm_hwspin_lock_unreg
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns 0 on success, or an appropriate error code on failure
> + * Returns: %0 on success, or an appropriate error code on failure
>   */
>  int devm_hwspin_lock_register(struct device *dev,
>  			      struct hwspinlock_device *bank,
> @@ -635,12 +639,13 @@ EXPORT_SYMBOL_GPL(devm_hwspin_lock_regis
> =20
>  /**
>   * __hwspin_lock_request() - tag an hwspinlock as used and power it up
> + * @hwlock: the target hwspinlock
>   *
>   * This is an internal function that prepares an hwspinlock instance
>   * before it is given to the user. The function assumes that
>   * hwspinlock_tree_lock is taken.
>   *
> - * Returns 0 or positive to indicate success, and a negative value to
> + * Returns: %0 or positive to indicate success, and a negative value to
>   * indicate an error (with the appropriate error code)
>   */
>  static int __hwspin_lock_request(struct hwspinlock *hwlock)
> @@ -680,7 +685,7 @@ static int __hwspin_lock_request(struct
>   * hwspin_lock_get_id() - retrieve id number of a given hwspinlock
>   * @hwlock: a valid hwspinlock instance
>   *
> - * Returns the id number of a given @hwlock, or -EINVAL if @hwlock is in=
valid.
> + * Returns: the id number of a given @hwlock, or -EINVAL if @hwlock is i=
nvalid.
>   */
>  int hwspin_lock_get_id(struct hwspinlock *hwlock)
>  {
> @@ -704,7 +709,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_get_id);
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns the address of the assigned hwspinlock, or NULL on error
> + * Returns: the address of the assigned hwspinlock, or %NULL on error
>   */
>  struct hwspinlock *hwspin_lock_request(void)
>  {
> @@ -747,7 +752,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_request);
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns the address of the assigned hwspinlock, or NULL on error
> + * Returns: the address of the assigned hwspinlock, or %NULL on error
>   */
>  struct hwspinlock *hwspin_lock_request_specific(unsigned int id)
>  {
> @@ -795,7 +800,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_request_sp
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns 0 on success, or an appropriate error code on failure
> + * Returns: %0 on success, or an appropriate error code on failure
>   */
>  int hwspin_lock_free(struct hwspinlock *hwlock)
>  {
> @@ -865,7 +870,7 @@ static void devm_hwspin_lock_release(str
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns 0 on success, or an appropriate error code on failure
> + * Returns: %0 on success, or an appropriate error code on failure
>   */
>  int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock)
>  {
> @@ -891,7 +896,7 @@ EXPORT_SYMBOL_GPL(devm_hwspin_lock_free)
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns the address of the assigned hwspinlock, or NULL on error
> + * Returns: the address of the assigned hwspinlock, or %NULL on error
>   */
>  struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
>  {
> @@ -926,7 +931,7 @@ EXPORT_SYMBOL_GPL(devm_hwspin_lock_reque
>   *
>   * Should be called from a process context (might sleep)
>   *
> - * Returns the address of the assigned hwspinlock, or NULL on error
> + * Returns: the address of the assigned hwspinlock, or %NULL on error
>   */
>  struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
>  						     unsigned int id)

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--mOVbuljTfi3zP5NN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZX04XwAKCRD2uYlJVVFO
o9fDAQDkpSZ4U3Qpa4PYiHfm4YYQZjAbNuzqOGQ1fU/xGeq27wEA47G+Vdh1addU
NiH0kE0HF/qZnD1BFPTGPZ3QudwujAY=
=Qb9i
-----END PGP SIGNATURE-----

--mOVbuljTfi3zP5NN--

