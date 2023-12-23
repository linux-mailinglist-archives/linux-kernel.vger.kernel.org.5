Return-Path: <linux-kernel+bounces-10358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF69681D357
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4458E28446B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B188F7E;
	Sat, 23 Dec 2023 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0RmTlNYm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FD8F56
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 09:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542B6C433C8;
	Sat, 23 Dec 2023 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703324172;
	bh=apKPcMM2Tuo6nxG+C7Mzh8MsFqhtU2+7qCuSbY76dBw=;
	h=Date:From:To:Cc:Subject:From;
	b=0RmTlNYmU1flAyugkSyI7zVI3T6sJOUEfX4hmb4xhNea/8bOtHJzN5VgdTYvtjbZY
	 DSp1fAyaJAQNReUZImIWJEs6sJWHG4ZNdhdOT/6wBUsoh7u3HFDHPHNVQneYMrML1c
	 fpHYknb/qup0rNT2hQVVQoUM0JBtbd1aiCUMk51A=
Date: Sat, 23 Dec 2023 10:36:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.7-rc6
Message-ID: <ZYaqCSpr15clmOb9@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc7

for you to fetch changes up to 159f5bdadcdda638aad5a234b58d6031aa4ef8aa:

  debugfs: initialize cancellations earlier (2023-12-22 07:33:02 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 6.7-rc7

Here are a small number of various driver fixes for 6.7-rc7 that
normally come through the char-misc tree, and one debugfs fix as well.
Included in here are:
  - iio and hid sensor driver fixes for a number of small things
  - interconnect driver fixes
  - brcm_nvmem driver fixes
  - debugfs fix for previous fix
  - guard() definition in device.h so that many subsystems can start
    using it for 6.8-rc1 (requested by Dan Williams to make future
    merges easier.)

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bjorn Andersson (1):
      interconnect: qcom: icc-rpm: Fix peak rate calculation

Dan Williams (1):
      driver core: Add a guard() definition for the device_lock()

David Lechner (1):
      iio: triggered-buffer: prevent possible freeing of wrong buffer

Fabio Estevam (1):
      dt-bindings: nvmem: mxs-ocotp: Document fsl,ocotp

George Stark (1):
      iio: adc: meson: add separate config for axg SoC family

Greg Kroah-Hartman (2):
      Merge tag 'icc-6.7-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus
      Merge tag 'iio-fixes-for-6.7a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Haibo Chen (1):
      iio: adc: imx93: add four channels for imx93 adc

Javier Carrasco (3):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table
      iio: tmag5273: fix temperature offset
      iio: adc: MCP3564: fix calib_bias and calib_scale range checks

Johannes Berg (1):
      debugfs: initialize cancellations earlier

Konrad Dybcio (1):
      interconnect: qcom: sm8250: Enable sync_state

Marius Cristea (1):
      iio: adc: MCP3564: fix hardware identification logic

Matti Vaittinen (1):
      iio: kx022a: Fix acceleration value scaling

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

Nuno Sa (2):
      iio: imu: adis16475: add spi_device_id table
      iio: imu: adis16475: use bit numbers in assign_bit()

Rafał Miłecki (1):
      nvmem: brcm_nvram: store a copy of NVRAM content

Srinivas Pandruvada (2):
      Revert "iio: hid-sensor-als: Add light chromaticity support"
      Revert "iio: hid-sensor-als: Add light color temperature support"

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Wadim Egorov (1):
      iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |  10 +-
 drivers/iio/accel/kionix-kx022a.c                  |  37 ++++--
 drivers/iio/adc/imx93_adc.c                        |   4 +
 drivers/iio/adc/mcp3564.c                          |   8 +-
 drivers/iio/adc/meson_saradc.c                     |  16 ++-
 drivers/iio/adc/ti_am335x_adc.c                    |   4 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |  10 ++
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   4 +-
 drivers/iio/imu/adis16475.c                        | 121 +++++++++++--------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   4 +-
 drivers/iio/light/hid-sensor-als.c                 | 100 +--------------
 drivers/iio/magnetometer/tmag5273.c                |   2 +-
 drivers/interconnect/core.c                        |   3 +
 drivers/interconnect/qcom/icc-rpm.c                |   2 +-
 drivers/interconnect/qcom/sm8250.c                 |   1 +
 drivers/nvmem/brcm_nvram.c                         | 134 +++++++++++++++------
 fs/debugfs/file.c                                  |   6 +-
 include/linux/device.h                             |   2 +
 include/linux/hid-sensor-ids.h                     |   4 -
 19 files changed, 254 insertions(+), 218 deletions(-)

