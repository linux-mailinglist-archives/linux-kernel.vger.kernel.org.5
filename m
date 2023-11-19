Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE367F08CA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 21:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjKSUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 15:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 15:15:06 -0500
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB98C6;
        Sun, 19 Nov 2023 12:15:02 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 707FA28EE6F;
        Sun, 19 Nov 2023 20:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1700424899;
        bh=lcbaEBamwZZqlpO4yCVGf/omm21hvJhW9yV/X3eU7hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dZObmTDMkk46dW92QzIT+tmHmAFhcb+dzo9oMVdXgImWS7Cr2pXTLshWcW1MX3sSm
         ohbUOUK23nt0DHwKdP7YWgjV+nRzlVzS9bSj13MWR/j/Q1l8dq+G1bbUcMGDG+wsSZ
         XbHwE4J6lV7jQrSAe9YjGBBzFxhXyP+3Dgsc8r/8=
Date:   Sun, 19 Nov 2023 22:14:58 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZVpswo3MSScT43Bo@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <20231119134939.GA8784-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119134939.GA8784-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Good morning!

On Sun, Nov 19, 2023 at 07:49:39AM -0600, Rob Herring wrote:
> On Fri, Nov 17, 2023 at 09:22:57PM +0200, Petre Rodan wrote:
> > Adds binding for digital Honeywell TruStability HSC and SSC series pressure 
> > and temperature sensors.
> > 
[..]
> > Changes for v2:
> > - Removed redundant quotations reported by robh's bot
> > - Fixed yamllint warnings
> > 
> > I'm failing to run 'make DT_CHECKER_FLAGS=-m dt_binding_check' due to
> > python errors and exceptions
> 
> What exceptions?

thanks for asking.

first off, installed packages. the first 4 are not part of the official Gentoo repo, so I might have prepared them with missing options if any where not included by default.
I know nothing about python.

$ equery l dtschema pylibfdt ruamel-yaml yamllint jsonschema python 
[I-O] [  ] dev-python/dtschema-2023.9:0
[I-O] [  ] dev-python/pylibfdt-1.7.0_p1:0
[I-O] [  ] dev-python/ruamel-yaml-0.18.5:0
[I-O] [  ] dev-python/yamllint-1.33.0:0
[IP-] [  ] dev-python/jsonschema-4.19.1:0
[IP-] [  ] dev-lang/python-2.7.18_p16-r1:2.7
[IP-] [  ] dev-lang/python-3.10.13:3.10
[IP-] [  ] dev-lang/python-3.11.5:3.11
prodan@sunspire /usr/src/linux-upstream $ python --version
Python 3.11.5

# binding check
prodan@sunspire /usr/src/linux-upstream $ make DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml  DT_CHECKER_FLAGS=-m dt_binding_check
Traceback (most recent call last):
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 1152, in resolve_fragment
    document = document[part]
               ~~~~~~~~^^^^^^
KeyError: 'definitions'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/lib/python-exec/python3.11/dt-doc-validate", line 64, in <module>
    ret |= check_doc(f)
           ^^^^^^^^^^^^
  File "/usr/lib/python-exec/python3.11/dt-doc-validate", line 32, in check_doc
    for error in sorted(dtsch.iter_errors(), key=lambda e: e.linecol):
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/dtschema/schema.py", line 123, in iter_errors
    for error in self.validator.iter_errors(self):
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 368, in iter_errors
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 335, in allOf
    yield from validator.descend(instance, subschema, schema_path=index)
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 416, in descend
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 284, in ref
    yield from validator._validate_reference(ref=ref, instance=instance)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 465, in _validate_reference
    return list(self.descend(instance, resolved))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 416, in descend
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 335, in allOf
    yield from validator.descend(instance, subschema, schema_path=index)
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 416, in descend
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 284, in ref
    yield from validator._validate_reference(ref=ref, instance=instance)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 465, in _validate_reference
    return list(self.descend(instance, resolved))
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 416, in descend
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 305, in properties
    yield from validator.descend(
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 416, in descend
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 34, in propertyNames
    yield from validator.descend(instance=property, schema=propertyNames)
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 416, in descend
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 335, in allOf
    yield from validator.descend(instance, subschema, schema_path=index)
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 416, in descend
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 378, in not_
    if validator.evolve(schema=not_schema).is_valid(instance):
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 483, in is_valid
    error = next(self.iter_errors(instance), None)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 368, in iter_errors
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 284, in ref
    yield from validator._validate_reference(ref=ref, instance=instance)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 461, in _validate_reference
    scope, resolved = resolve(ref)
                      ^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 1086, in resolve
    return url, self._remote_cache(url)
                ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 1104, in resolve_from_url
    return self.resolve_fragment(document, fragment)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 1154, in resolve_fragment
    raise exceptions._RefResolutionError(
jsonschema.exceptions._RefResolutionError: Unresolvable JSON pointer: 'definitions/json-schema-prop-names'
Error: Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.example.dts:36.15-16 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.example.dtb] Error 1
make[1]: *** [/usr/src/linux-upstream/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

best regards,
peter

-- 
petre rodan
